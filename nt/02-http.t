use v6;

use Test;

use LibCurl::HTTP;

my $version = LibCurl::HTTP.version;

like $version, /^libcurl/, 'LibCurl Version';

diag $version;

my $curl = LibCurl::HTTP.new;

isa-ok $curl, LibCurl::HTTP, 'Created Object';

#
# GET
#
my $x = $curl.GET('http://example.com').perform;

is $curl.response-code, 200, 'Response code';

is $curl.statusline, 'HTTP/1.1 200 OK', 'Status line';

is $curl.Content-Type, 'text/html', 'Content-Type';

is $curl.receiveheaders<Content-Type>, 'text/html', 'Receive Headers';

is $curl.buf.bytes, $curl.Content-Length, 'Correct Content-Length';

#
# HEAD
#
$curl.HEAD('http://example.com').perform;

is $curl.response-code, 200, 'Response code';

is $curl.statusline, 'HTTP/1.1 200 OK', 'Status line';

is $curl.Content-Type, 'text/html', 'Content-Type';

is $curl.receiveheaders<Content-Type>, 'text/html', 'Receive Headers';

is $curl.buf.bytes, 0, 'No Body.';

done-testing;
