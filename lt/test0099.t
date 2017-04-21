use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 5;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(
    URL => "http://$HOSTIP:$HTTPPORT/99",
    resume-from => 9999999999);

throws-like { $curl.perform }, X::LibCurl,
    message => "Requested range was not delivered by the server";

is $curl.response-code, 404, 'response-code';

is $curl.statusline, 'HTTP/1.1 404 Nah', 'statusline';

is $server.input,
"GET /99 HTTP/1.1
Range: bytes=9999999999-
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'input';

throws-like { $curl.perform }, X::LibCurl,
    Int => CURLE_RANGE_ERROR;

done-testing;
