use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 4;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(
    URL => "http://$HOSTIP:$HTTPPORT/we/want/that/page/84",
    proxy => "$HOSTIP:$HTTPPORT",
    userpwd => 'iam:myself').perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.0 200 OK', 'statusline';

is $curl.content, "contents\n", 'no content';

is $server.input,
"GET http://$HOSTIP:$HTTPPORT/we/want/that/page/84 HTTP/1.1
Authorization: Basic aWFtOm15c2VsZg==
Host: $HOSTIP:$HTTPPORT
Accept: */*
Proxy-Connection: Keep-Alive

", 'Correct input';

done-testing;
