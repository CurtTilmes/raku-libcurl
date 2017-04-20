use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 4;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/70",
                             userpwd => 'testuser:testpass',
                             httpauth => CURLAUTH_ANY)
    .perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.1 200 OK',
    'statusline';

is $curl.content, "This IS the real page!\n", 'content';

is $server.input,
qq<GET /70 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

GET /70 HTTP/1.1
Authorization: Digest username="testuser", realm="testrealm", nonce="1053604199", uri="/70", response="2c9a6f00af0d86497b177b90e90c688a"
Host: $HOSTIP:$HTTPPORT
Accept: */*

>, 'Correct input';

done-testing;
