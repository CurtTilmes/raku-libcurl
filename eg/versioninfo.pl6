use v6;

use LibCurl::Easy;

my $v = LibCurl::Easy.version-info;

say $v.age;
say $v.version;
say $v.version-num.fmt('%x');
say $v.host;
say $v.features-code;

say $v.features;
say $v.features<LIBZ>;
say $v.features<DEBUG>;

say $v.ssl-version;

say $v.ssl-version-num;

say $v.libz-version;

say $v.protocols;

say $v.protocols<http>;

say $v.ares;
say $v.ares-num;

say $v.libidn;

say $v.iconv-ver-num;

say $v.libssh-version;
