#!/usr/bin/env raku
use Test;
use Test::When <release>;

use LibCurl::Easy;

plan 2;

unless LibCurl::Easy.version-info.check('7.56')
{
    skip-rest "libcurl version too old for forms";
    exit;
}

ok my $req = LibCurl::Easy.new(URL => 'http://localhost'), 'Make object';

# https://github.com/CurtTilmes/perl6-libcurl/issues/1

ok $req.formadd(name => 'test', contents => 1), 'Add form with Int';

done-testing;
