use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 4;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT?mooo/59").perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.0 200 OK swsclose', 'statusline';

is $curl.content, "hej \n", 'content';

is $server.input,
"GET /?mooo/59 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'Correct input';

done-testing;
