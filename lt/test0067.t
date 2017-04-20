use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 3;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/67",
                             userpwd => 'testuser:testpass',
                             httpauth => CURLAUTH_NTLM)
    .perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.1 200 Things are fine in server land swsclose',
    'statusline';

is $curl.content, "Finally, this is the real page!\n", 'content';

done-testing;
