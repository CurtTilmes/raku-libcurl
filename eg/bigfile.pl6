use v6;

use LibCurl::Easy;

my $curl = LibCurl::Easy.new(:followlocation, :!noprogress);

$curl.URL("https://ladsweb.modaps.eosdis.nasa.gov/archive/allData/6/MOD02HKM/2017/011/MOD02HKM.A2017011.0130.006.2017011134502.hdf");

$curl.download("MOD02HKM.A2017011.0130.006.2017011134502.hdf");

$curl.perform;

say $curl.statusline;

