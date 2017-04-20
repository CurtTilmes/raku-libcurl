use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 6;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/77",
    timevalue => DateTime.new('1999-12-12T12:00:00Z').posix,
    timecondition => CURL_TIMECOND_IFMODSINCE)
    .perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.1 200 OK', 'statusline';

is $curl.content, "-foo-\n", 'content';

is $curl.Last-Modified, 'Tue, 13 Jun 2010 12:10:00 GMT', 'Last-Modified';

is $curl.ETag, '"21025-dc7-39462498"', 'Etag';

is $server.input,
"GET /77 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*
If-Modified-Since: Sun, 12 Dec 1999 12:00:00 GMT

", 'Correct input';

done-testing;
