use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 4;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(:httpproxytunnel,
    URL => "http://test.83:$HTTPPORT/we/want/that/page/83",
    proxy => "$HOSTIP:$HTTPPORT",
    userpwd => 'iam:my:;self',
    proxyuserpwd => 'youare:yourself').perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.1 200 OK', 'statusline';

is $curl.content, "contents\n", 'no content';

is $server.input,
"CONNECT test.83:$HTTPPORT HTTP/1.1
Host: test.83:$HTTPPORT
Proxy-Authorization: Basic eW91YXJlOnlvdXJzZWxm
Proxy-Connection: Keep-Alive

GET /we/want/that/page/83 HTTP/1.1
Authorization: Basic aWFtOm15OjtzZWxm
Host: test.83:$HTTPPORT
Accept: */*

", 'Correct input';

done-testing;
