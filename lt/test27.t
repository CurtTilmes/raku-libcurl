use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 13;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/want/27",
                             cookiefile => 'none').perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, "HTTP/1.1 200 Mooo swsclose", 'statusline';

is $curl.content, "*flopp*\n", 'content';

is $curl.cookielist,
[ "$HOSTIP	FALSE	/	FALSE	0	thewinneris	nowayyouwin" ],
'cookielist';

$curl.perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, "HTTP/1.1 200 Mooo swsclose", 'statusline';

is $curl.content, "*flopp*\n", 'content';

is $curl.cookielist,
[ "$HOSTIP	FALSE	/	FALSE	0	thewinneris	nowayyouwin" ],
'cookielist';

$curl.perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, "HTTP/1.1 200 Mooo swsclose", 'statusline';

is $curl.content, "*flopp*\n", 'content';

is $curl.cookielist,
[ "$HOSTIP	FALSE	/	FALSE	0	thewinneris	nowayyouwin" ],
'cookielist';

is $server.input,
"GET /want/27 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

GET /want/27 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*
Cookie: thewinneris=nowayyouwin

GET /want/27 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*
Cookie: thewinneris=nowayyouwin

", 'input';

done-testing;
