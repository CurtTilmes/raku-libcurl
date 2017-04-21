use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 4;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(
    URL => "http://$HOSTIP:$HTTPPORT/97",
    Content-Type => 'silly/type',
    postfields => 'hejsanallabarn')
    .perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.0 200 OK', 'statusline';

is $curl.content, "blaha\n", 'content';

is $server.input,
"POST /97 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*
Content-Type: silly/type
Content-Length: 14

hejsanallabarn", 'Correct input';

done-testing;
