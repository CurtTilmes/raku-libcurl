#
# certinfo still doesn't work quite right...
#
use v6;

use LibCurl::Easy;

my $curl = LibCurl::Easy.new(URL => 'https://www.example.com',
                             :!ssl-verifypeer, :!ssl-verifyhost,
                             :verbose, :certinfo).perform;

say $curl.response-code;

say $curl.certinfo;
