use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 4;

my $server = LibCurl::Test.new;

$server.restart;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/64",
                             userpwd => 'testuser:testpass',
                             httpauth => 'CURLAUTH_DIGEST')
    .perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.1 200 OK swsclose', 'statusline';

is $curl.content, "This IS the real page!\n", 'content';

$curl.cleanup;

is $server.input,
qq<GET /64 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

GET /64 HTTP/1.1
Authorization: Digest username="testuser", realm="testrealm", nonce="1053604145", uri="/64", response="c55f7f30d83d774a3d2dcacf725abaca"
Host: $HOSTIP:$HTTPPORT
Accept: */*

>, 'input';

$server.stop;

done-testing;
