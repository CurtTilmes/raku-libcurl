use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 5;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(:followlocation);

$curl.URL("http://$HOSTIP:$HTTPPORT/want/54").perform;

is $curl.response-code, 302, 'response-code';

is $curl.statusline, 'HTTP/1.1 302 This is a weirdo text message swsclose', 'statusline';

is $curl.content, "This server reply is for testing\n", 'content';

is $curl.Location, '', 'Location';

is $server.input,
"GET /want/54 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'input';

done-testing;
