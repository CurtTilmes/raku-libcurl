use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 7;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(:nobody);

$curl.URL("http://$HOSTIP:$HTTPPORT/48?foo=moo&moo=poo").perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.1 200 OK', 'statusline';

$curl.perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.1 200 OK', 'statusline';

is $curl.content, '', 'content';

is $curl.Date, "Thu, 09 Nov 2010 14:49:00 GMT", 'Date';

$curl.cleanup;

is $server.input,
"HEAD /48?foo=moo&moo=poo HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

HEAD /48?foo=moo&moo=poo HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

[DISCONNECT]
", 'input';

done-testing;
