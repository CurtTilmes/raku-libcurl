use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 6;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(:followlocation,
    URL => "http://$HOSTIP:$HTTPPORT/we/are/all/twits/42").perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.1 200 OK swsclose', 'statusline';

is $server.input,
"GET /we/are/all/twits/42 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

GET /we/are/all/m%20o%20o.html/420002 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'input';

is $curl.Location, 'this should be ignored', 'Location';

is $curl.effective-url, "http://127.0.0.1:8990/we/are/all/m%20o%20o.html/420002", 'effective-url';

is $curl.content, "body\n", 'Content';

done-testing;
