use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 4;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(
    URL => "http://$HOSTIP:$HTTPPORT/93",
    proxy => "$HOSTIP:$HTTPPORT").perform;

is $curl.response-code, 407, 'response-code';

is $curl.statusline, 'HTTP/1.1 407 Needs proxy authentication',
    'statusline';

is $curl.content, "bing\n", 'content';

is $server.input,
"GET http://$HOSTIP:$HTTPPORT/93 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*
Proxy-Connection: Keep-Alive

", 'input';
done-testing;
