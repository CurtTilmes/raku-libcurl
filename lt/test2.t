use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 6;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/2",
                             userpwd => 'fake:user').perform;

is $server.input,
"GET /2 HTTP/1.1
Authorization: Basic ZmFrZTp1c2Vy
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'Correct input';

is $curl.response-code, 200, 'response-code';

is $curl.content, '', 'Empty body';

is $curl.statusline, 'HTTP/1.1 200 OK', 'statusline';

is $curl.receiveheaders<Content-Type>, 'text/html', 'Content-Type';

is $curl.receiveheaders<Funny-head>, 'yesyes', 'Funny-head';

done-testing;
