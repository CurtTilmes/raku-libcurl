use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 5;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/want/28",
                             :followlocation).perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, "HTTP/1.1 200 Followed here fine swsclose", 'statusline';

is $curl.content, "If this is received, the location following worked\n\n",
    'content';

is $server.input,
"GET /want/28 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

GET /online/1,1795,Welcome,00.html/280002.txt?logout=TRUE HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*

", 'input';

is $curl.effective-url, "http://$HOSTIP:$HTTPPORT/online/1,1795,Welcome,00.html/280002.txt?logout=TRUE", 'effective-url';

done-testing;
