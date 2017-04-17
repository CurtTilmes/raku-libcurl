use v6;

use LibCurl::Easy;

sub dump(LibCurl::Easy $easy, CURL-INFO-TYPE $type, Buf $buf)
{
    my $str = $buf.decode;  # Only do this if you know the data are ok for it!

    say "$type - $str";

    return 0;
}

my $curl = LibCurl::Easy.new(URL => 'http://example.com/',
                             debugfunction => &dump).perform;

say $curl.statusline;
