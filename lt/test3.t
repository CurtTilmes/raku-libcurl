use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 4;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/3",
                             userpwd => 'fake:user',
                             Expect => '');

$curl.postfields("fooo=mooo&pooo=clue&doo=%20%20%20++++");

$curl.perform;

is $server.input,
"POST /3 HTTP/1.1
Authorization: Basic ZmFrZTp1c2Vy
Host: $HOSTIP:$HTTPPORT
Accept: */*
Content-Length: 37
Content-Type: application/x-www-form-urlencoded

fooo=mooo&pooo=clue&doo=%20%20%20++++", 'Correct input';

is $curl.response-code, 200, 'response-code';

is $curl.buf, Buf.new, 'Content Buf';

is $curl.Content-Length, 0, 'Content-Length';

done-testing;
