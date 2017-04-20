use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 4;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/34").perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, "HTTP/1.1 200 funky chunky!", 'statusline';

is $curl.Transfer-Encoding, 'chunked', 'Transfer-Encoding';

is $curl.content, "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc\n", 'content';

done-testing;
