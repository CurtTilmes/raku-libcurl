use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 3;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(:followlocation,
    URL => "http://$HOSTIP:$HTTPPORT/91",
    userpwd => 'mydomain\\myself:secret',
    httpauth => CURLAUTH_ANY).perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.1 200 Things are fine in server land swsclose',
    'statusline';

is $curl.content, "Finally, this is the real page!\n", 'content';

done-testing;
