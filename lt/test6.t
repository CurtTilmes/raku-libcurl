use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 3;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new;

$curl.URL("http://$HOSTIP:$HTTPPORT/we/want/that/page/6");

$curl.cookie("name=contents;name2=content2");

$curl.perform;

is $server.input,
"GET /we/want/that/page/6 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*
Cookie: name=contents;name2=content2

", 'Content';

is $curl.response-code, 200, 'response-code';

is $curl.get-header('swsclose'), 'booo', 'closed connection';

done-testing;
