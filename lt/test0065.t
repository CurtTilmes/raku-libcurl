use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 4;

my $server = LibCurl::Test.new;

$server.restart;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/65",
                             userpwd => 'testuser:test2pass',
                             httpauth => 'CURLAUTH_DIGEST')
    .perform;

is $curl.response-code, 401, 'response-code';

is $curl.statusline, 'HTTP/1.1 401 Still a bad password you moron',
    'statusline';

is $curl.content, "This is not the real page either\r\n", 'content';

$curl.cleanup;

is $server.input,
qq<GET /65 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

GET /65 HTTP/1.1
Authorization: Digest username="testuser", realm="testrealm", nonce="2053604145", uri="/65", response="66d68d3251f1839576ba7c766cf9205b"
Host: $HOSTIP:$HTTPPORT
Accept: */*

>, 'input';

$server.stop;

done-testing;
