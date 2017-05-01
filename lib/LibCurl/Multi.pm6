use v6;

use NativeCall;

use LibCurl::Easy;
use LibCurl::MultiHandle;

my enum CURLMOPT_TYPE <CURLMOPT_STR CURLMOPT_LONG CURLMOPT_CALLBACK>;

my %opts =
    max-host-connections  => (CURLMOPT_MAX_HOST_CONNECTIONS,  CURLMOPT_LONG ),
    max-pipeline-length   => (CURLMOPT_MAX_PIPELINE_LENGTH,   CURLMOPT_LONG ),
    max-total-connections => (CURLMOPT_MAX_TOTAL_CONNECTIONS, CURLMOPT_LONG ),
    maxconnects           => (CURLMOPT_MAXCONNECTS,           CURLMOPT_LONG ),
    pipelining            => (CURLMOPT_PIPELINING,            CURLMOPT_LONG ),
    callback              => (0,                          CURLMOPT_CALLBACK ),
;

class LibCurl::Multi
{
    has LibCurl::MultiHandle $.multi;
    has %.easy-handles;
    has $.easy-handles-lock = Lock.new;
    has &.callback;

    method new(|opts) returns LibCurl::Multi
    {
        my $self = self.bless(multi => LibCurl::MultiHandle.new);
        $self.setopt(|opts);
        return $self;
    }

    method setopt(*%options) returns LibCurl::Multi
    {
        for %options.kv -> $option, $param
        {
            die "Unknown option $option" unless %opts{$option};

            my ($code, $type) = %opts{$option};

            given $type
            {
                when CURLMOPT_LONG {
                    $!multi.setopt($code, $param);
                }

                when CURLMOPT_CALLBACK {
                    &!callback = $param;
                }
            }
        }
        return self;
    }

    method add-handle(*@handles) returns LibCurl::Multi
    {
        for @handles -> $easy
        {
            $easy.prepare;
            $!easy-handles-lock.protect({
                %!easy-handles{$easy.handle.id} = $easy;
            });
            $!multi.add-handle($easy.handle);
        }
        return self;
    }

    method remove-handle(*@handles) returns LibCurl::Multi
    {
        for @handles -> $easy
        {
            $!multi.remove-handle($easy.handle);
            $!easy-handles-lock.protect({
                %!easy-handles{$easy.handle.id}:delete;
            });
        }
        return self;
    }

    method perform($timeout-ms = 1000, *%options)
    {
        my int32 $running-handles = %.easy-handles.elems;
        my int32 $numfds = 0;

        self.setopt(|%options) if %options;

        repeat {
            $!multi.perform($running-handles);

            $!multi.wait($timeout-ms, $numfds);

            my int32 $msgs-in-queue = 0;
            while my $msg = $!multi.info($msgs-in-queue)
            {
                next unless $msg.msg == CURLMSG_DONE;
                my $easy = %!easy-handles{$msg.handle.id};
                $easy.finish;
                self.remove-handle($easy);
                next unless &!callback;
                &!callback($easy, 
                           $msg.code == CURLE_OK
                           ?? Exception
                           !! X::LibCurl.new(code => $msg.code));
            }
        } while $running-handles;

        return self;
    }

    submethod DESTROY { $!multi.cleanup }
}
