use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 2;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/want/25",
                             :followlocation, maxredirs => 5);

throws-like { $curl.perform }, X::LibCurl,
    message => "Number of redirects hit maximum amount";

throws-like { $curl.perform }, X::LibCurl,
    Int => 47;

done-testing;
