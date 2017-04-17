use v6;

use LibCurl::Easy;
use LibCurl::Multi;

my $curl1 = LibCurl::Easy.new(:followlocation, URL => 'http://example.com');
my $curl2 = LibCurl::Easy.new(:followlocation, URL => 'http://example.com');

sub callback(LibCurl::Easy $easy, Exception $e)
{
    die $e if $e;
    say $easy.statusline;
}

my $multi = LibCurl::Multi.new(callback => &callback);

$multi.add-handle($curl1, $curl2);

$multi.perform;

say "done";
