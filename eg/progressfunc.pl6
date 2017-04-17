use v6;

use LibCurl::Easy;

sub xferinfo(LibCurl::Easy $easy, $dltotal, $dlnow, $ultotal, $ulnow)
{
    say "$dltotal $dlnow $ultotal $ulnow";
    return 0;
}

my $curl = LibCurl::Easy.new(URL => 'http://example.com/',
                             xferinfofunction => &xferinfo).perform;

say $curl.statusline;
