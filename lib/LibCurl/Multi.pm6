use v6;

use NativeCall;
use LibCurl::EasyHandle;
use LibCurl::Easy;
use LibCurl::MultiHandle;

my enum CURLMOPT_TYPE <CURLMOPT_STR CURLMOPT_LONG>;

my %opts =
    max-host-connections  => (CURLMOPT_MAX_HOST_CONNECTIONS,  CURLMOPT_LONG ),
    max-pipeline-length   => (CURLMOPT_MAX_PIPELINE_LENGTH,   CURLMOPT_LONG ),
    max-total-connections => (CURLMOPT_MAX_TOTAL_CONNECTIONS, CURLMOPT_LONG ),
    max-connects          => (CURLMOPT_MAXCONNECTS,           CURLMOPT_LONG ),
    pipelining            => (CURLMOPT_PIPELINING,            CURLMOPT_LONG ),
;

class LibCurl::Multi
{
    has LibCurl::MultiHandle $.multi;
    has %.easy-handles;
    has %.callbacks;

    method new(|opts)
    {
        my $self = self.bless(multi => LibCurl::MultiHandle.new);
        $self.setopt(|opts);
        return $self;
    }

    method setopt(*%options)
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
            }
        }
    }

    method add-handle(LibCurl::Easy $easy, &callback?)
    {
        $easy.prepare;
        %!easy-handles{$easy.handle.id} = $easy;
        %!callbacks{$easy.handle.id} = &callback if &callback;
        $!multi.add-handle($easy.handle);
    }

    method remove-handle(LibCurl::Easy $easy)
    {
        $!multi.remove-handle($easy.handle);
        %!easy-handles{$easy.handle.id}:delete;
        %!callbacks{$easy.handle.id}:delete;
    }

    method perform($timeout-ms = 1000)
    {
        my int32 $running-handles = %.easy-handles.elems;
        my int32 $numfds = 0;

        repeat {
            $!multi.perform($running-handles);

            $!multi.wait($timeout-ms, $numfds);

            my int32 $msgs-in-queue = 0;
            while my $msg = $!multi.info($msgs-in-queue)
            {
                next unless $msg.msg == CURLMSG_DONE;
                my $easy = %!easy-handles{$msg.handle.id};
                my $callback = %!callbacks{$easy.handle.id};
                $easy.finish;
                self.remove-handle($easy);
                next unless $callback;
                $callback($easy, 
                          $msg.code == CURLE_OK
                          ?? Exception
                          !! X::LibCurl.new(code => $msg.code));
            }
        } while $running-handles;
    }

    submethod DESTROY { $!multi.cleanup }
}
