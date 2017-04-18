use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 2;

my $curl = LibCurl::Easy.new(URL => "htfp://$HOSTIP:$HTTPPORT/none.htfml");

throws-like { $curl.perform }, X::LibCurl,
    message => "Unsupported protocol";

throws-like { $curl.perform }, X::LibCurl,
    Int => 1;

done-testing;
