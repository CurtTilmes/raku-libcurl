use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 2;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/36");

throws-like { $curl.perform }, X::LibCurl,
    message => "Failure when receiving data from the peer";

throws-like { $curl.perform }, X::LibCurl,
    Int => 56;

done-testing;
