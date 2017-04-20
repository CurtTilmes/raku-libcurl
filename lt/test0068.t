use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 3;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/68",
                             userpwd => 'testuser:testpass',
                             httpauth => CURLAUTH_NTLM)
    .perform;

is $curl.response-code, 401, 'response-code';

is $curl.statusline, 'HTTP/1.1 401 You give me wrong password',
    'statusline';

is $curl.content, "Wrong password dude. Get it fixed and return.\n", 'content';

done-testing;
