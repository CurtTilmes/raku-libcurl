# See https://github.com/curl/curl/issues/639

use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

my $datafile will leave { unlink $_ } = "test9.txt";

spurt $datafile,
"foo-
This is a moo-
bar
";

plan 3;

my $server = LibCurl::Test.new;

$server.start;

my $curl = LibCurl::Easy.new(URL => "http://$HOSTIP:$HTTPPORT/we/want/9");

$curl.formadd(name => 'name', contents => 'daniel');

$curl.formadd(name => 'tool', contents => 'curl');

$curl.formadd(name => 'file', file => 'test9.txt');

$curl.perform;

is $curl.response-code, 200, 'response-code';

is $curl.statusline, 'HTTP/1.0 200 OK swsclose', 'statusline';

is $curl.content, "blablabla\n\n", 'content';

done-testing;
