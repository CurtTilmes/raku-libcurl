use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 6;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/that.site.com/17",
                             useragent => "agent007 license to drill\t",
                             customrequest => 'MOOO').perform;

is $curl.response-code, 200, 'response-code';

is $server.input,
"MOOO /that.site.com/17 HTTP/1.1
User-Agent: agent007 license to drill	
Host: 127.0.0.1:8990
Accept: */*

", 'input';

is $curl.content, "This is the proof it works\n", 'Content';

is $curl.Content-Length, 27, 'Content-Length';

is $curl.statusline, "HTTP/1.1 200 OK", 'statusline';

is $curl.Funny-head, 'yesyes', 'header';

done-testing;
