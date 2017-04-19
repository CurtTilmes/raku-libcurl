use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 3;

my $testfile will leave { unlink $_ } = 'test33.txt';

spurt $testfile,
qq<012345678
012345678
012345678
012345678
012345678
012345678
012345678
012345678
012345678
012345678
>;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/33",
                             upload => $testfile);

$curl.resume-from(50).perform;

is $curl.response-code, 200, 'response-code';

is $server.input,
"PUT /33 HTTP/1.1
Content-Range: bytes 50-99/100
Host: $HOSTIP:$HTTPPORT
Accept: */*
Content-Length: 50
Expect: 100-continue

012345678
012345678
012345678
012345678
012345678
", 'input';

is $curl.statusline, "HTTP/1.1 200 OK swsclose", 'statusline';

done-testing;
