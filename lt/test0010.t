use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 3;

my $putfile will leave { unlink $_ } = "test10.txt";

spurt $putfile,
qq<Weird
     file
         to
   upload
for
   testing
the
   PUT
      feature
>;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/we/want/10",
                             upload => $putfile).perform;

is $curl.response-code, 200, 'response-code';


is $server.input,
"PUT /we/want/10 HTTP/1.1
Host: $HOSTIP:$HTTPPORT
Accept: */*
Content-Length: 78
Expect: 100-continue

Weird
     file
         to
   upload
for
   testing
the
   PUT
      feature
", 'input';

is $curl.content, "blablabla\n\n", "Content";

done-testing;
