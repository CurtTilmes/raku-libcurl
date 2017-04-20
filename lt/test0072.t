use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 4;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/72",
                             userpwd => 'testuser:testpass',
                             httpauth => CURLAUTH_ANY)
    .perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.1 200 OK',
    'statusline';

is $curl.content, "This IS the real page!\n", 'content';

is $server.input,
qq<GET /72 HTTP/1.1
Host: 127.0.0.1:8990
Accept: */*

GET /72 HTTP/1.1
Authorization: Digest username="testuser", realm="testrealm", nonce="1053604199", uri="/72", response="9fcd1330377365a09bbcb33b2cbb25bd"
Host: 127.0.0.1:8990
Accept: */*

>, 'Correct input';

done-testing;
