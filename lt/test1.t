use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 10;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/1").perform;

is $server.input,
"GET /1 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'Correct input';

is $curl.response-code, 200, 'response-code';

is $curl.Server, 'test-server/fake', 'Server';

is $curl.ETag, '"21025-dc7-39462498"', 'ETag';

is $curl.content, "-foo-\n", 'Content';

is $curl.Content-Type, 'text/html', 'Content-Type';

is $curl.Content-Length, 6, 'Content-Length';

is $curl.Accept-Ranges, 'bytes', 'Accept-Ranges';

is $curl.Funny-head, 'yesyes', 'Funny-head';

is $curl.Connection, 'close', 'Connection';


done-testing;
