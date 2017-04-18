use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 5;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/want/15").perform;

is $curl.response-code, 200, 'response-code';

is $server.input,
"GET /want/15 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'input';

is $curl.content, "Repeated nonsense-headers\n", 'Content';

is $curl.Content-Length, 26, 'Content-Length';

is $curl.statusline, "HTTP/1.4 200 OK", 'statusline';

done-testing;
