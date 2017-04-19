use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 2;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/want/30",
                             timeout => 2);

throws-like { $curl.perform }, X::LibCurl,
    message => "Server returned nothing (no headers, no data)";

throws-like { $curl.perform }, X::LibCurl,
    Int => 52;

done-testing;
