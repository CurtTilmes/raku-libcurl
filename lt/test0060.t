use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 4;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/bzz/60");

$curl.send("more than one byte\n")
     .infilesize(-1)                # On purpose!
     .Content-Length(1)
     .perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.0 200 OK swsclose', 'statusline';

is $curl.content, "blablabla\n\n", 'content';

$curl.cleanup;

is $server.input,
"PUT /bzz/60 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*
Transfer-Encoding: chunked
Content-Length: 1
Expect: 100-continue

13
more than one byte

0

", 'Correct input';

done-testing;
