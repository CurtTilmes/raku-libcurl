use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 3;

my $server = LibCurl::Test.new;

$server.start-ftp;

my $curl = LibCurl::Easy.new(URL => "ftp://$HOSTIP:$FTPPORT/test-100/").perform;

is $curl.response-code, 226, 'response-code';

is $curl.content,
"total 20
drwxr-xr-x   8 98       98           512 Oct 22 13:06 .
drwxr-xr-x   8 98       98           512 Oct 22 13:06 ..
drwxr-xr-x   2 98       98           512 May  2  1996 curl-releases
-r--r--r--   1 0        1             35 Jul 16  1996 README
lrwxrwxrwx   1 0        1              7 Dec  9  1999 bin -> usr/bin
dr-xr-xr-x   2 0        1            512 Oct  1  1997 dev
drwxrwxrwx   2 98       98           512 May 29 16:04 download.html
dr-xr-xr-x   2 0        1            512 Nov 30  1995 etc
drwxrwxrwx   2 98       1            512 Oct 30 14:33 pub
dr-xr-xr-x   5 0        1            512 Oct  1  1997 usr
", 'Content';

$curl.cleanup;

is $server.input,
"USER anonymous
PASS ftp@example.com
PWD
CWD test-100
EPSV
TYPE A
LIST
QUIT
", 'input';

done-testing;
