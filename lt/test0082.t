use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 4;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/82",
                             proxy => "http://$HOSTIP:$HTTPPORT",
                             proxyuserpwd => 'testuser:testpass').perform;

is $curl.response-code, 407, 'response-code';

is $curl.statusline, 'HTTP/1.1 407 We only deal with NTLM my friend',
    'statusline';

is $curl.content, "This is not the real page either!\n", 'no content';

is $server.input,
"GET http://$HOSTIP:$HTTPPORT/82 HTTP/1.1
Proxy-Authorization: Basic dGVzdHVzZXI6dGVzdHBhc3M=
Host: $HOSTIP:$HTTPPORT
Accept: */*
Proxy-Connection: Keep-Alive

", 'Correct input';

done-testing;
