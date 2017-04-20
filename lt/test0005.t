use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 2;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new;

$curl.URL("http://$HOSTIP:$HTTPPORT/we/want/that/page/5#5");

$curl.proxy("$HOSTIP:$HTTPPORT");

$curl.perform;

is $server.input,
"GET http://$HOSTIP:$HTTPPORT/we/want/that/page/5 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*
Proxy-Connection: Keep-Alive

", 'Content';

is $curl.response-code, 200, 'response-code';

done-testing;
