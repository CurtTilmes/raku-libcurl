use v6;

use NativeCall;

our $HOSTIP is export = %*ENV{'PERL6-LIBCURL-HOSTIP'} // '127.0.0.1';

our $HTTPPORT is export = %*ENV{'PERL6-LIBCURL-HTTPPORT'} // 8990;

my $CURL-TEST-DIR = %*ENV{'PERL6-LIBCURL-TESTDIR'}
                    // $*PROGRAM.parent.child('../../curl/tests');

sub fork() returns int32 is native { * }
sub daemon(int32 $nochdir, int32 $noclose) returns int32 is native { * }

class LibCurl::Test
{
    method start()
    {
        indir $CURL-TEST-DIR,
        { 
            unlink <log/server.input log/server.response>;

            return if '.http_server.pid'.IO.e;

            if fork() == 0
            {
                daemon(1, 0);

                shell "./httpserver.pl --pidfile .http_server.pid --logfile log/http_server.log --ipv4 --port $HTTPPORT --srcdir .";

                exit 0;
            }

            sleep 1;
        };
    }

    method stop()
    {
        indir $CURL-TEST-DIR,
        {
            shell Q<kill `cat .http_server.pid`>;
            sleep 1;
        };
    }

    method input()
    {
        $CURL-TEST-DIR.child('log/server.input').slurp;
    }

    method response()
    {
        $CURL-TEST-DIR.child('log/server.response').slurp;
    }
}
