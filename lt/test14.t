use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 5;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/want/14",
                             :nobody, :header).perform;

is $curl.response-code, 200, 'response-code';

is $server.input,
"HEAD /want/14 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'input';

is $curl.content, 
"HTTP/1.1 200 OK
Server: thebest/1.0
Connection: close

", 'Content';

is $curl.statusline, "HTTP/1.1 200 OK", 'statusline';

is $curl.Server, "thebest/1.0", 'Server';

done-testing;
