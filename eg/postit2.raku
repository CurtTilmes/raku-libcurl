#!/usr/bin/env raku
use LibCurl::Easy;

my $curl = LibCurl::Easy.new(URL => 'http://httpbin.org/post');

# Upload this file
$curl.formadd(name => 'sendfile', file => 'postit2.raku');

# Fill in the 'filename' field
$curl.formadd(name => 'filename', contents => 'postit2.raku');

# Add the submit button, even if this is rarely needed
$curl.formadd(name => 'submit', contents => 'send');

$curl.perform;

say $curl.response-code;

say $curl.content;
