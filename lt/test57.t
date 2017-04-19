use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 5;

my $outfile will leave { unlink $_ } = 'out57';

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(download => $outfile);

$curl.URL("http://$HOSTIP:$HTTPPORT/57").perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.1 200 OK swsclose', 'statusline';

is $curl.Content-Type, "text/html; charset=ISO-8859-4", 'Content-Type';

is $curl.Funny-head, 'yesyes', 'Funny head';

is $server.input,
"GET /57 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'input';

done-testing;
