use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 5;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/47",
                             http-version => CURL_HTTP_VERSION_1_0).perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.0 200 OK swsclose', 'statusline';

is $curl.Server, 'test-server/fake', 'Server';

is $server.input,
"GET /47 HTTP/1.0
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'input';

is $curl.content, "-foo- within foo -!foo-\n", 'content';

done-testing;
