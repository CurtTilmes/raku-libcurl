use v6;

use Test;

use LibCurl::Easy;

my $version = LibCurl::Easy.version;

like $version, /^libcurl/, 'LibCurl Version';

diag $version;

my $curl = LibCurl::Easy.new(URL => 'http://example.com');

isa-ok $curl, LibCurl::Easy, 'Created Object';

is $curl.effective-url, 'http://example.com', 'URL set';

$curl.setopt(private => 'my stuff');

is $curl.private, 'my stuff', 'Private';

$curl.perform;

is $curl.response-code, 200, 'Response code';

is $curl.statusline, 'HTTP/1.1 200 OK', 'Status line';

is $curl.Content-Type, 'text/html', 'Content-Type';

is $curl.receiveheaders<Content-Type>, 'text/html', 'Receive Headers';

is $curl.buf.bytes, $curl.Content-Length, 'Correct Content-Length';

done-testing;
