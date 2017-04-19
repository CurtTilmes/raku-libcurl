use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 5;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(:followlocation);

$curl.URL("http://$HOSTIP:$HTTPPORT/we/are/all/twits/49").perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.1 200 OK swsclose', 'statusline';

is $curl.content, "body\n", 'content';

is $curl.Date, "Thu, 09 Nov 2010 14:49:00 GMT", 'Date';

is $server.input,
"GET /we/are/all/twits/49 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

GET /we/are/all/moo.html/490002 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'input';

done-testing;
