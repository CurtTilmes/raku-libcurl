use v6;

use Test;
use Test::When <online>;

use LibCurl::Easy;

plan 2;

ok my $req = LibCurl::Easy.new(URL => 'http://localhost'), 'Make object';

# https://github.com/CurtTilmes/perl6-libcurl/issues/1

ok $req.formadd(name => 'test', contents => 1), 'Add form with Int';
