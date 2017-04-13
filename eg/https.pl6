use v6;

use LibCurl::Easy;

say LibCurl::Easy.new(URL => 'https://example.com/')
    .perform.content;

