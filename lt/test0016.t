use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 8;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://we.want.that.site.com/16",
    proxy => "$HOSTIP:$HTTPPORT");

$curl.proxyuserpwd('fake@user:loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong');

$curl.perform;

is $curl.response-code, 200, 'response-code';

is $server.input,
"GET http://we.want.that.site.com/16 HTTP/1.1
Proxy-Authorization: Basic ZmFrZUB1c2VyOmxvb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29vb29uZw==
Host: we.want.that.site.com
Accept: */*
Proxy-Connection: Keep-Alive

", 'input';

is $curl.content, "the content goes here\n", 'Content';

is $curl.Content-Length, 22, 'Content-Length';

is $curl.statusline, "HTTP/1.1 200 OK", 'statusline';

is $curl.Funny-head, 'yesyes', 'header';

is $curl.Server, 'test-server/fake', 'Server';

is $curl.Content-Type, 'text/html', 'Content-Type';

done-testing;
