use v6;

use LibCurl::Easy;
use LibCurl::Multi;

say LibCurl::Easy.version;

my $curl = LibCurl::Easy.new(:followlocation, URL => 'http://example.com');

my $multi = LibCurl::Multi.new;

$multi.add-handle($curl);

$multi.perform;

say $curl.statusline;

CATCH {
      when X::LibCurl {
           say $_;
           say $_.Int;
       }
}

say "done";
