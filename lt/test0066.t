use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 4;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/66")
    .perform;

is $curl.response-code, 0, 'response-code';

is $curl.statusline, Any, 'statusline';

is $curl.content, "no headers swsclose\n", 'content';

is $server.input,
"GET /66 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'input';

done-testing;
