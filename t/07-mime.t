#!/usr/bin/env raku
use Test;
use Test::When <release>;
use LibCurl::Easy;
use JSON::Fast;

plan 8;

unless LibCurl::Easy.version-info.check('7.56')
{
    skip-rest "libcurl version too old for forms";
    exit;
}

isa-ok my $curl = LibCurl::Easy.new(URL => 'http://httpbin.org/post'),
    LibCurl::Easy, 'Create object';

with $curl
{
    ok .formadd(name => 'string', contents => 'a string'), 'Add form string';
    ok .formadd(name => 'buf', contents => 'abc'.encode), 'Add form buf';

    ok .perform, 'Perform';

    is .response-code, 200, 'response code';

    with from-json .content
    {
        like .<headers><Content-Type>, rx{'multipart/form-data'}, 'Content-Type';
        is .<form><string>, 'a string', 'form string right';
        is .<form><buf>, 'abc', 'form buf right';
    }
}

done-testing;
