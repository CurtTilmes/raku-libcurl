# See https://github.com/curl/curl/issues/639

use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

my $cookiefile = "cookiefile";

spurt $cookiefile,
qq<HTTP/1.1 200 OK
Date: Thu, 09 Nov 2010 14:49:00 GMT
Server: test-server/fake
Content-Type: text/html
Funny-head: yesyes
Set-Cookie: foobar=name; domain=$HOSTIP; path=/;
Set-Cookie: mismatch=this; domain=$HOSTIP; path="/silly/";
Set-Cookie: partmatch=present; domain=.0.0.1; path=/w;
Set-Cookie: duplicate=test; domain=.0.0.1; domain=.0.0.1; path=/donkey;
Set-Cookie: cookie=yes; path=/we;
Set-Cookie: cookie=perhaps; path=/we/want;
Set-Cookie: name with space=is weird but; path=/we/want;
Set-Cookie: trailingspace    = removed; path=/we/want;
Set-Cookie: nocookie=yes; path=/WE;
Set-Cookie: blexp=yesyes; domain=$HOSTIP; domain=$HOSTIP; expiry=totally bad;
Set-Cookie: partialip=nono; domain=.0.0.1;
>;

plan 2;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/we/want/8",
                             useragent => 'testing', :$cookiefile).perform;

is $curl.response-code, 200, 'response-code';

if 1
{
    skip 'My curl version is old'
}
else
{
is $server.input,
"GET /we/want/8 HTTP/1.1
User-Agent: testing
Host: $HOSTIP:$HTTPPORT
Accept: */*
Cookie: cookie=perhaps; name with space=is weird but; trailingspace=removed; cookie=yes; foobar=name; blexp=yesyes

", 'Correct input';
}

unlink $cookiefile;

done-testing;
