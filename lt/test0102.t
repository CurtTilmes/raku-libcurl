use v6;

use Test;

use LibCurl::Test;
use LibCurl::Easy;

plan 3;

my $server = LibCurl::Test.new;

$server.start-ftp;

my $curl = LibCurl::Easy.new(URL => "ftp://$HOSTIP:$FTPPORT/102").perform;

is $curl.response-code, 226, 'response-code';

is $curl.content,
"data
    to
      see
that FTP
works
  so does it?
", 'Content';

$curl.cleanup;

is $server.input,
"USER anonymous
PASS ftp@example.com
PWD
EPSV
TYPE I
SIZE 102
RETR 102
QUIT
", 'input';

done-testing;
