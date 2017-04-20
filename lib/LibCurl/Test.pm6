use v6;

use NativeCall;

our $HOSTIP is export = %*ENV{'PERL6-LIBCURL-HOSTIP'} // '127.0.0.1';

our $HTTPPORT is export = %*ENV{'PERL6-LIBCURL-HTTPPORT'} // 8990;

our $PROXYPORT is export = %*ENV{'PERL6-LIBCURL-PROXYPORT'} // 9013;

my $CURL-TEST-DIR = %*ENV{'PERL6-LIBCURL-TESTDIR'}
                    // $*PROGRAM.parent.child('../../curl/tests');

sub fork() returns int32 is native { * }
sub daemon(int32 $nochdir, int32 $noclose) returns int32 is native { * }
sub sysexit(int32 $status) is symbol('exit') is native { * }

class LibCurl::Test
{
    method start()
    {
        indir $CURL-TEST-DIR,
        { 
            unlink <log/server.input log/server.response>;

            return if self.running;

            if fork() == 0
            {
                daemon(1, 0);

                my $cmd = shell "./httpserver.pl --pidfile .http_server.pid --logfile log/http_server.log --ipv4 --port $HTTPPORT --srcdir . &", :out;

                $cmd.out.close;

                sysexit 0;
            }

            sleep 2;
        };
    }

    method start-proxy
    {
        indir $CURL-TEST-DIR,
        { 
            unlink <log/proxy.input log/proxy.response>;

            return if self.running-proxy;

            if fork() == 0
            {
                daemon(1, 0);

                my $cmd = shell "./httpserver.pl --connect $HOSTIP --pidfile .http2_server.pid --logfile log/http2_server.log --id 2 --ipv4 --port $PROXYPORT --srcdir . &", :out;

                $cmd.out.close;

                sysexit 0;
            }

            sleep 2;
        };
    }

    method running()
    {
        '.http_server.pid'.IO.e;
    }

    method running-proxy()
    {
        '.http2_server.pid'.IO.e;
    }

    method stop()
    {
        indir $CURL-TEST-DIR,
        {
            while self.running
            {
                shell Q<kill `cat .http_server.pid`>;
                sleep 1;
            }
        };
    }

    method stop-proxy()
    {
        indir $CURL-TEST-DIR,
        {
            while self.running
            {
                shell Q<kill `cat .http2_server.pid`>;
                sleep 1;
            }
        };
    }

    method restart()
    {
        self.stop;
        sleep 2;
        self.start;
    }

    method input()
    {
        $CURL-TEST-DIR.child('log/server.input').slurp;
    }

    method input-proxy()
    {
        $CURL-TEST-DIR.child('log/proxy.input').slurp;
    }

    method response()
    {
        $CURL-TEST-DIR.child('log/server.response').slurp;
    }
}
