use v6;

use Test;
use Test::When <online>;

use LibCurl::Easy;

my $version = LibCurl::Easy.version;

my $curl = LibCurl::Easy.new(URL => 'http://greenbytes.de/tech/tc/httpcontenttype/textplainutf8.asis')
    .perform;

is $curl.content, "Umlaute: äöüÄÖÜ Euro: €\n",
    'Check decoded content, charset=UTF-8';


$curl.URL('http://greenbytes.de/tech/tc/httpcontenttype/textplainutf8qs.asis')
    .perform;

is $curl.content, "Umlaute: äöüÄÖÜ Euro: €\n",
    'Check decoded content, charset="UTF-8"';

$curl.URL('http://greenbytes.de/tech/tc/httpcontenttype/textplainutf8ws.asis')
    .perform;

is $curl.content, "Umlaute: äöüÄÖÜ Euro: €\n",
    'Check decoded content, charset = UTF-8';


$curl.URL('http://greenbytes.de/tech/tc/httpcontenttype/textplainutf8qsa.asis')
    .perform;

is $curl.content, "Umlaute: äöüÄÖÜ Euro: €\n",
    "Check decoded content, charset='UTF-8'";

$curl.URL('http://greenbytes.de/tech/tc/httpcontenttype/textplainutf8extparam.asis')
    .perform;

is $curl.content, "Umlaute: äöüÄÖÜ Euro: €\n",
    'Check decoded content, charset="UTF-8"';


$curl.URL('http://greenbytes.de/tech/tc/httpcontenttype/textplainutf8extparamqs1.asis')
    .perform;

is $curl.content, "Umlaute: äöüÄÖÜ Euro: €\n",
    'Check decoded content, charset=\"UTF-8\"';

done-testing;
