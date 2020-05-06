use v6;

use NativeCall;

our $HOSTIP is export = %*ENV{'PERL6-LIBCURL-HOSTIP'} // '127.0.0.1';

our $CLIENTIP is export = %*ENV{'PERL6-LIBCURL-CLIENTIP'} // '127.0.0.1';

our $HTTPPORT is export = %*ENV{'PERL6-LIBCURL-HTTPPORT'} // 8990;

our $FTPPORT is export = %*ENV{'PERL6-LIBCURL-FTPPORT'} // 8992;

our $PROXYPORT is export = %*ENV{'PERL6-LIBCURL-PROXYPORT'} // 9013;

my $CURL-TEST-DIR = %*ENV{'PERL6-LIBCURL-TESTDIR'}
                    // $*PROGRAM.parent.child('../../curl/tests');

sub fork() returns int32 is native { * }
sub daemon(int32 $nochdir, int32 $noclose) returns int32 is native { * }
sub sysexit(int32 $status) is symbol('exit') is native { * }

sub start-server(:$server, :$pidfile, :$logfile, :$port, *@opts)
{
    indir $CURL-TEST-DIR,
    {
        unlink <log/server.input log/server.response
                log/proxy.input log/proxy.response>;

        return if $pidfile.IO.e;

        if fork() == 0
        {
            daemon(1, 0);
            my $cmd = shell "./$server --pidfile $pidfile --logfile $logfile --port $port --srcdir . @opts.join(' ') &", :out;

            $cmd.out.close;

            sysexit 0;
        }
    }
    sleep 2;
}

class LibCurl::Test
{
    method start()
    {
        start-server(server => 'httpserver.pl',
                     pidfile => '.http_server.pid',
                     logfile => 'log/http_server.log',
                     port => $HTTPPORT,
                     '--ipv4');
    }

    method start-proxy
    {
        start-server(server => 'httpserver.pl',
                     pidfile => '.http2_server.pid',
                     logfile => 'log/http2_server.log',
                     port => $PROXYPORT,
                     '--id', 2, '--ipv4', '--connect', $HOSTIP)
    }

    method start-ftp
    {
        start-server(server => 'ftpserver.pl',
                     pidfile => '.ftp_server.pid',
                     logfile => 'log/ftp_server.log',
                     port => $FTPPORT,
                     '--proto', 'ftp', '--ipv4', '--addr', $HOSTIP);
    }

    method running()
    {
        '.http_server.pid'.IO.e;
    }

    method running-proxy()
    {
        '.http2_server.pid'.IO.e;
    }

    method running-ftp()
    {
        '.ftp_server.pid'.IO.e;
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
            while self.running-proxy
            {
                shell Q<kill `cat .http2_server.pid`>;
                sleep 1;
            }
        };
    }

    method stop-ftp()
    {
        indir $CURL-TEST-DIR,
        {
            while self.running-ftp
            {
                shell Q<kill `cat .ftp_server.pid`>;
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
