use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 12;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/want/12",
                             range => '100-200').perform;

is $curl.response-code, 206, 'response-code';

is $server.input,
"GET /want/12 HTTP/1.1
Range: bytes=100-200
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'input';

is $curl.content, "..partial data returned from the
server as a result of setting an explicit byte range
in the request
", 'Content';

is $curl.statusline, "HTTP/1.1 206 Partial Content", 'statusline';

is $curl.ETag, '"21025-dc7-39462498"', 'ETag';

is $curl.Accept-Ranges, 'bytes', 'Accept-Ranges';

is $curl.Content-Length, 101, 'Content-Length';

is $curl.Content-Range, 'bytes 100-200/3527', 'Content-Range';

is $curl.Connection, 'close', 'Connection';

is $curl.Content-Type, 'text/html', 'Content-Type';

is $curl.Server, 'Apache/1.3.11 (Unix) PHP/3.0.14', 'Server';

is $curl.Last-Modified, 'Tue, 13 Jun 2000 12:10:00 GMT', 'Last-Modified';

done-testing;
