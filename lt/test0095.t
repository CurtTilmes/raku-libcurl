use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 5;

my $server = LibCurl::Test.new;

$server.start;

$server.start-proxy;

my $curl = LibCurl::Easy.new(:httpproxytunnel,
    URL => "http://test.95:$HTTPPORT/we/want/that/page/95",
    proxy => "$HOSTIP:$PROXYPORT",
    postfields => 'datatopost=ohthatsfunyesyes').perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, "HTTP/1.1 200 OK", 'statusline';

is $curl.content, "contents\n", 'Content';

is $server.input-proxy,
"CONNECT test.95:$HTTPPORT HTTP/1.1
Host: test.95:$HTTPPORT
Proxy-Connection: Keep-Alive

", 'proxy input';


is $server.input,
"POST /we/want/that/page/95 HTTP/1.1
Host: test.95:$HTTPPORT
Accept: */*
Content-Length: 27
Content-Type: application/x-www-form-urlencoded

datatopost=ohthatsfunyesyes", 'input';

done-testing;
