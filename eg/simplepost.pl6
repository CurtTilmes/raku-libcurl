use v6;

use LibCurl::Easy;

my $postthis = 'moo mooo moo moo';

say LibCurl::Easy.new(postfields => $postthis, URL => 'http://example.com')
    .perform.content;

