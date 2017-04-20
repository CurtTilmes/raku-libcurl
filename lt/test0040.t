use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 5;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(:followlocation,
    URL => "http://$HOSTIP:$HTTPPORT/we/are/all/twits/40").perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.1 200 OK swsclose', 'statusline';

is $server.input,
"GET /we/are/all/twits/40 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

GET /we/are/all/moo.html/?name=d+a+niel&testcase=/400002 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'input';

is $curl.Location, 'this should be ignored', 'Location';

is $curl.effective-url, "http://$HOSTIP:$HTTPPORT/we/are/all/moo.html/?name=d+a+niel&testcase=/400002", 'effective-url';

done-testing;
