use v6;

use LibCurl::Easy;

my $curl = LibCurl::Easy.new(:verbose, URL => 'http://example.com');

# Remove a header curl would otherwise add by itself
$curl.set-header(Accept => '');

# Add a custom header
$curl.set-header(Another => 'yes');

# Modify a header curl otherwise adds differently
$curl.set-header(Host => 'www.example.com');

# Add a header with "blank" contents to the right of the colon
$curl.set-header(X-silly-header => ';');

say $curl.perform.content;
