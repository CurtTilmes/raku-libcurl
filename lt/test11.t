use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 5;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/want/11",
                             :followlocation).perform;

is $curl.response-code, 200, 'response-code';

is $server.input,
"GET /want/11 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

GET /want/data/110002.txt?coolsite=yes HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'input';

is $curl.content, "If this is received, the location following worked\n\n",
    "Content";

is $curl.effective-url,
    "http://$HOSTIP:$HTTPPORT/want/data/110002.txt?coolsite=yes",
    "Effective URL";

is $curl.Location, "data/110002.txt?coolsite=yes", "Location";

done-testing;
