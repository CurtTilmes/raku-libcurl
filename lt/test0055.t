use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 5;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(:followlocation);

$curl.URL("http://$HOSTIP:$HTTPPORT/55").perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.1 200 OK swsclose', 'statusline';

is $curl.content, "body\n", 'content';

is $curl.Location, '550002', 'Location';

is $server.input,
"GET /55 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

GET /550002 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'input';

done-testing;
