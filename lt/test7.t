use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 2;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/we/want/7",
                             cookiefile => '').perform;

is $curl.response-code, 200, 'response-code';

is $curl.cookielist, 
[
'127.0.0.1	FALSE	/	FALSE	0	foobar	name',
'127.0.0.1	FALSE	"/silly/"	FALSE	0	mismatch	this',
], 'Cookielist';

done-testing;
