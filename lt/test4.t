use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 2;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/4");

$curl.set-header(extra-header => 'here',
                 Accept => 'replaced',
                 X-Custom-Header => ';',
                 X-Test => 'foo; ');

$curl.set-header(X-Test => '');

$curl.set-header(X-Test2 => 'foo;',
                 X-Test3 => ' ');

$curl.perform;

is $server.input,
"GET /4 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
X-Test: foo; 
Accept: replaced
X-Custom-Header:
extra-header: here
X-Test2: foo;

", 'Content';

is $curl.response-code, 200, 'response-code';

done-testing;
