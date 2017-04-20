use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 3;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/want/38",
                             resume-from => 78);

throws-like { $curl.perform }, X::LibCurl,
    message => "Requested range was not delivered by the server";

is $server.input,
"GET /want/38 HTTP/1.1
Range: bytes=78-
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'input';


throws-like { $curl.perform }, X::LibCurl,
    Int => 33;

done-testing;
