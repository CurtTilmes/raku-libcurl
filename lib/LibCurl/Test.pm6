use v6;

our $HOSTIP is export = %*ENV{'PERL6-LIBCURL-HOSTIP'} // '127.0.0.1';

our $HTTPPORT is export = %*ENV{'PERL6-LIBCURL-HTTPPORT'} // 8990;

my $CURL-TEST-DIR = %*ENV{'PERL6-LIBCURL-TESTDIR'}
                    // $*PROGRAM.parent.child('../../curl/tests');

class LibCurl::Test
{
    method start()
    {
        indir $CURL-TEST-DIR,
        { 
            shell 'rm -f log/server.input log/server.response';
            return if ".http_server.pid".IO.e;
            shell Q<./httpserver.pl --pidfile ".http_server.pid" --logfile "log/http_server.log" --ipv4 --port $HTTPPORT --srcdir . &>;
            sleep 2;
        };
    }

    method stop()
    {
        indir $CURL-TEST-DIR,
        {
            shell Q<kill `cat .http_server.pid`>;
            sleep 2;
        };
    }

    method input()
    {
        $CURL-TEST-DIR.child("log/server.input").slurp;
    }

    method response()
    {
        $CURL-TEST-DIR.child("log/server.response").slurp;
    }
}
