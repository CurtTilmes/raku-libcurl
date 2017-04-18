use v6;

use Test;

use LibCurl::Easy;

plan 2;

my $curl = LibCurl::Easy.new(URL => "non-existing-host.haxx.se.");

throws-like { $curl.perform }, X::LibCurl,
    message => "Couldn't resolve host name";

throws-like { $curl.perform }, X::LibCurl,
    Int => 6;

done-testing;
