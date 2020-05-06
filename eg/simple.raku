#!/usr/bin/env raku
use LibCurl::Easy;

say LibCurl::Easy.new(:followlocation, URL => 'http://example.com')
    .perform.content;

