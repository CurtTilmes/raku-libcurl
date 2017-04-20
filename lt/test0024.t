use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 2;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/24",
                             :failonerror);

throws-like { $curl.perform }, X::LibCurl,
    message => "HTTP response code said error";

throws-like { $curl.perform }, X::LibCurl,
    Int => 22;

done-testing;
