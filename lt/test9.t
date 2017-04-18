use v6;

use Test;

use LibCurl::Test;
use LibCurl::EasyHandle;
use LibCurl::Easy;

my $postfile = "test9.txt";

spurt $postfile,
qq<foo-
This is a moo-
bar
>;

#plan 2;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/we/want/9",
                             );

# Can't make a multipart form yet

$curl.perform;

is $curl.response-code, 200, 'response-code';

is $curl.content, "blablabla\n\n", 'Content';

unlink $postfile;

done-testing;
