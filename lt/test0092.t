use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 7;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(
    URL => "http://$HOSTIP:$HTTPPORT/want/92",
    resume-from => 87).perform;

is $curl.response-code, 416, 'response-code';

is $curl.statusline, 'HTTP/1.1 416 Requested Range Not Satisfiable',
    'statusline';

is $curl.content, "bad\n", 'content';

is $curl.ETag, '"ab57a-507-3f9968f3"', 'ETag';

is $curl.Content-Range, 'bytes */87', 'Content-Range';

is $curl.Content-Type, 'image/gif', 'Content-Type';

is $server.input,
"GET /want/92 HTTP/1.1
Range: bytes=87-
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'input';
done-testing;
