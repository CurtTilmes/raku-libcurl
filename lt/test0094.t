use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 3;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(
    URL => "https://test.anything.really.com:94",
    proxytype => CURLPROXY_HTTP_1_0,
    proxy => "$HOSTIP:$HTTPPORT");

throws-like { $curl.perform }, X::LibCurl,
    Int => 56;

throws-like { $curl.perform }, X::LibCurl,
    message => "Failure when receiving data from the peer";

is $server.input,
"CONNECT test.anything.really.com:94 HTTP/1.0
Host: test.anything.really.com:94
Proxy-Connection: Keep-Alive

CONNECT test.anything.really.com:94 HTTP/1.0
Host: test.anything.really.com:94
Proxy-Connection: Keep-Alive

", 'input';

done-testing;
