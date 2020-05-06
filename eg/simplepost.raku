#!/usr/bin/env raku
use LibCurl::Easy;

my $postthis = 'moo mooo moo moo';

say LibCurl::Easy.new(postfields => $postthis, URL => 'http://httpbin.org/post')
    .perform.content;

