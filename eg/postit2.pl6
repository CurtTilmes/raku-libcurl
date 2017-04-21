use v6;

use LibCurl::Easy;

my $curl = LibCurl::Easy.new(URL => 'http://example.com/examplepost.cgi');

# Upload this file
$curl.formadd(name => 'sendfile', file => 'postit2.pl6');

# Fill in the 'filename' field
$curl.formadd(name => 'filename', contents => 'postit2.pl6');

# Add the submit button, even if this is rarely needed
$curl.formadd(name => 'submit', contents => 'send');

$curl.perform;

say $curl.response-code;

say $curl.content;
