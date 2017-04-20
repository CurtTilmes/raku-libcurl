use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 2;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/want/29",
                             timeout => 2);

throws-like { $curl.perform }, X::LibCurl,
    message => "Timeout was reached";

throws-like { $curl.perform }, X::LibCurl,
    Int => 28;

$server.stop;

done-testing;
