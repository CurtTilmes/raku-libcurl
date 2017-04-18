use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 6;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/want/13",
                             customrequest => 'DELETE').perform;

is $curl.response-code, 200, 'response-code';

is $server.input,
"DELETE /want/13 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'input';

is $curl.content, "blabla custom request result\n", 'Content';

is $curl.statusline, "HTTP/1.1 200 Read you", 'statusline';

is $curl.Content-Length, 29, 'Content-Length';

is $curl.Deleted, 'suppose we got a header like this! ;-)', 'Deleted header';

done-testing;
