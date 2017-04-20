use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 5;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(:followlocation,
    URL => "http://$HOSTIP:$HTTPPORT/want/45").perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.1 200 Followed here fine swsclose', 'statusline';

is $server.input,
"GET /want/45 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

GET /want/data.cgi?moo=http://&/450002 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'input';

is $curl.effective-url, "http://$HOSTIP:$HTTPPORT/want/data.cgi?moo=http://&/450002", 'effective-url';

is $curl.content, "If this is received, the location following worked\n\n", 'content';

done-testing;
