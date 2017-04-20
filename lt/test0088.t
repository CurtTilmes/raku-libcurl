use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 3;

my $put88 will leave { unlink $_ } = 'put88';

spurt $put88,
"This is data we upload with PUT
a second line
line three
four is the number of lines
";

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(upload => $put88,
    URL => "http://$HOSTIP:$HTTPPORT/88",
    userpwd => 'testuser:testpass',
    httpauth => CURLAUTH_DIGEST).perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.1 200 OK swsclose', 'statusline';

is $server.input,
qq<PUT /88 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*
Content-Length: 0
Expect: 100-continue

PUT /88 HTTP/1.1
Authorization: Digest username="testuser", realm="testrealm", nonce="1053604145", uri="/88", response="78a49fa53d0c228778297687d4168e71"
Host: $HOSTIP:$HTTPPORT
Accept: */*
Content-Length: 85
Expect: 100-continue

This is data we upload with PUT
a second line
line three
four is the number of lines
>, 'Correct input';

done-testing;
