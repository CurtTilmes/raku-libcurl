use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 6;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new;

$curl.URL("http://$HOSTIP:$HTTPPORT/32?foo=moo&moo=poo").perform;

is $curl.response-code, 200, 'response-code';

is $server.input,
"GET /32?foo=moo&moo=poo HTTP/1.1
Host: 127.0.0.1:8990
Accept: */*

", 'input';

is $curl.content, "-foo-\n", 'Content';

is $curl.Content-Length, 6, 'Content-Length';

is $curl.statusline, "HTTP/1.1 200 OK", 'statusline';

is $curl.Funny-head, 'yesyes', 'header';

done-testing;
