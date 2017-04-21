use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 4;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(
    URL => "http://$HOSTIP:$HTTPPORT/98",
    Content-Length => '14',
    Transfer-Encoding => '',
    send => "data on stdin\n")  # Not really on stdin ;-)
    .perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.0 200 OK', 'statusline';

is $curl.content, "blaha\n", 'content';

is $server.input,
"PUT /98 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*
Content-Length: 14
Expect: 100-continue

data on stdin
", 'Correct input';

done-testing;
