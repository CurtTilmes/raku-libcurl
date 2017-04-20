use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 5;

my $infile will leave { unlink $_ } = '58te[]st.txt';

spurt $infile, "a few bytes\n";

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(upload => $infile);

$curl.URL("http://$HOSTIP:$HTTPPORT/we/want/" ~ $curl.escape($infile)).perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.0 200 OK swsclose', 'statusline';

is $curl.effective-url, "http://$HOSTIP:$HTTPPORT/we/want/58te%5B%5Dst.txt",
    'effective-url';

is $curl.content, "blablabla\n\n", 'content';

is $server.input,
"PUT /we/want/58te%5B%5Dst.txt HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*
Content-Length: 12
Expect: 100-continue

a few bytes
", 'input';

done-testing;
