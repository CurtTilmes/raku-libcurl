use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 4;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(
    URL => "ftp://$HOSTIP:$HTTPPORT/we/want/that/page/79",
    proxy => "$HOSTIP:$HTTPPORT")
    .perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.0 200 OK', 'statusline';

is $curl.content, "contents\n", 'no content';

is $server.input,
"GET ftp://127.0.0.1:8990/we/want/that/page/79 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*
Proxy-Connection: Keep-Alive

", 'Correct input';

done-testing;
