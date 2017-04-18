use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 2;

my $curl = LibCurl::Easy.new(URL => "$HOSTIP:60000");

throws-like { $curl.perform }, X::LibCurl, message => "Couldn't connect to server";

throws-like { $curl.perform }, X::LibCurl, Int => 7;

done-testing;
