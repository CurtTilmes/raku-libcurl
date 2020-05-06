#!/usr/bin/env raku
use LibCurl::Easy;

say LibCurl::Easy.new(URL => 'https://example.com/')
    .perform.content;

