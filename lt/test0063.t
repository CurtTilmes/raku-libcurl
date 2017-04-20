use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 4;

my $server = LibCurl::Test.new;

$server.start;

# It will use http_proxy from %*ENV as well, but I just pass it in here.
# It reads the env before I could set it here.

my $curl = LibCurl::Easy.new(URL => "http://we.want.that.site.com/63",
                             proxy => "http://fake:user@127.0.0.1:8990")
    .perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.1 200 OK swsclose', 'statusline';

is $server.input,
"GET http://we.want.that.site.com/63 HTTP/1.1
Proxy-Authorization: Basic ZmFrZTp1c2Vy
Host: we.want.that.site.com
Accept: */*
Proxy-Connection: Keep-Alive

", 'input';

is $curl.content, "the content would go here\n", 'content';

done-testing;
