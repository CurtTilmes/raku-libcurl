use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 5;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(:followlocation,
    proxy => "$HOSTIP:$HTTPPORT",
    URL => "http://$HOSTIP:$HTTPPORT/want/43").perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.1 200 Followed here fine swsclose', 'statusline';

is $server.input,
"GET http://$HOSTIP:$HTTPPORT/want/43 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*
Proxy-Connection: Keep-Alive

GET http://$HOSTIP:$HTTPPORT/want/data/430002.txt?coolsite=yes HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*
Proxy-Connection: Keep-Alive

", 'input';

is $curl.effective-url, "http://$HOSTIP:$HTTPPORT/want/data/430002.txt?coolsite=yes", 'effective-url';

is $curl.content, "If this is received, the location following worked\n\n", 'content';

done-testing;
