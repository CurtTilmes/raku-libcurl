Perl6 LibCurl
=============

A [Perl 6](https://perl6.org/) interface to
[libcurl](https://curl.haxx.se/libcurl/).

    libcurl is a free and easy-to-use client-side URL transfer
    library, supporting DICT, FILE, FTP, FTPS, Gopher, HTTP, HTTPS,
    IMAP, IMAPS, LDAP, LDAPS, POP3, POP3S, RTMP, RTSP, SCP, SFTP,
    SMTP, SMTPS, Telnet and TFTP. libcurl supports SSL certificates,
    HTTP POST, HTTP PUT, FTP uploading, HTTP form based upload,
    proxies, cookies, user+password authentication (Basic, Digest,
    NTLM, Negotiate, Kerberos), file transfer resume, http proxy
    tunneling and more!

    libcurl is highly portable, it builds and works identically on
    numerous platforms, including Solaris, NetBSD, FreeBSD, OpenBSD,
    Darwin, HPUX, IRIX, AIX, Tru64, Linux, UnixWare, HURD, Windows,
    Amiga, OS/2, BeOs, Mac OS X, Ultrix, QNX, OpenVMS, RISC OS, Novell
    NetWare, DOS and more...

    libcurl is free, thread-safe, IPv6 compatible, feature rich, well
    supported, fast, thoroughly documented and is already used by many
    known, big and successful companies and numerous applications.

Simple Examples
===============

    use LibCurl::Easy;

GET:

    print LibCurl::Easy.new(URL => 'http://example.com').perform.content;

HEAD:

    say LibCurl::Easy.new(:nobody, URL => 'http://example.com')
        .perform.response-code;

PUT:

    LibCurl::Easy.new(URL => 'http://example.com',
                      send => 'My Content').perform;

DELETE:

    LibCurl::Easy.new(URL => 'http://example.com/file-to-delete',
                      customrequest => 'DELETE').perform;

POST:

    TBD

LibCurl::HTTP
=============

If even those aren't easy enough, there is a tiny sub-class LibCurl::HTTP
that adds aliases for the common HTTP methods:

    use LibCurl::Easy;

    my $http = LibCurl::HTTP.new;

    say $http.GET('http://example.com').perform.content;

    say $http.GET('http://example.com', 'myfile.html').perform.response-code;

    say $http.HEAD('http://example.com').perform.response-code;

    $http.DELETE('http://example.com').perform;

    $http.PUT('http://example.com', 'myfile').perform;

Fancier Example
===============

    my $curl = LibCurl::Easy.new(:verbose, :followlocation);
    $curl.setopt(URL => 'http://example.com', download => './myfile.html');
    $curl.perform;
    say $curl.Content-Type;
    say $curl.Content-Length;
    say $curl.Date;
    say $curl.response-code;
    say $curl.statusline;

Options
=======

Many of the libcurl
[options](https://curl.haxx.se/libcurl/c/curl_easy_setopt.html) are
available, mostly just skip the ```CURLOPT_```, lowercase, and use '-'
instead of '_'.  For example, instead of
```CURLOPT_ACCEPT_ENCODING```, use ```accept-encoding```.  When the
options are really boolean (set to 1 to enable and 0 to disable), you
can treat them like Perl booleans if you want, ```:option``` to
enable, and ```:!option``` to disable.

Just like libcurl, the primary option is
[URL](https://curl.haxx.se/libcurl/c/CURLOPT_URL.html), and can take
many forms depending on the desired protocol.

Options can be set on a handle either on initial creation with
```new()```, or later with ```.setopt()```.  As a convenience, you can
also just treat them like normal object methods.  These are all
equivalent:

    my $curl = LibCurl::Easy.new(:verbose, :followlocation,
                                 URL => 'http://example.com');

    $curl.setopt(:verbose, followlocation => 1);
    $curl.setopt(URL => 'http://example.com');

    $curl.verbose(1);
    $curl.followlocation(1);
    $curl.URL('http://example.com');

These are the current options (If you want one not in this list, let
me know):

CAinfo CApath URL accepttimeout-ms accept-encoding address-scope
append autoreferer buffersize certinfo cookie cookiefile cookiejar
cookielist customrequest failonerror followlocation forbid-reuse
fresh-connect ftp-skip-pasv-ip ftp-use-eprt ftp-use-epsv ftpport
header httpauth httpget httpproxytunnel low-speed-limit low-speed-time
maxconnects maxfilesize maxredirs max-send-speed max-recv-speed netrc
nobody noprogress nosignal password postfields postfieldsize protocols
proxy proxyport proxytype proxyuserpwd redir-protocols referer
ssl-verifyhost ssl-verifypeer timeout timeout-ms unrestricted-auth
use-ssl useragent username userpwd verbose wildcardmatch

Header Options
==============

In addition to the normal libcurl special headers ('useragent',
'referer', 'cookie'), there are some extra options for headers:
Content-MD5, Content-Type, Host, Accept, Expect.

    $curl.Host('somewhere.com');  # or $curl.setopt(Host => 'somewhere.com')
    $curl.Content-MD5('...');     # or $curl.setopt(Content-MD5 => '...')

You can also add any other headers you like:

    $curl.set-header(X-My-Header => 'something', X-something => 'foo');

You can clear a standard header by setting the header to '', or send a
header without content by setting the content to ';'

    $curl.set-header(Accept => '');      # Don't send normal Accept header
    $curl.set-header(Something => ';');  # Send empty header

If you are reusing the handle, you can also clear the set headers:

    $curl.clear-header();

This only clears the 'extra' headers, not useragent/referer/cookie.

Special Options
===============

In addition to the normal libcurl options, Perl6 LibCurl uses options
for some special Perl functionality.

*debugfunction* replaces the libcurl CURLOPT_DEBUGFUNCTION callback,
with one that looks like this:

    sub debug(LibCurl::Easy $easy, CURL-INFO-TYPE $type, Buf $buf)

    $curl.setopt(debugfunction => &debug);

*xferinfo* replaces the libcurl CURLOPT_XFERINFOFUNCTION (and
CURLOPT_PROGRESSFUNCTION) with one that looks like this:

    sub xferinfo(LibCurl::Easy $easy, $dltotal, $dlnow, $ultotal, $ulnow)

    $curl.setopt(xferinfofunction => &xferinfo

*download* specifies a filename to download into.

*upload* specifies a filename to upload from.

*send* specifies a Perl Str or a Perl Buf to send content from.

Finally there is a 'private' option which replaces CURLOPT_PRIVATE,
but you can safely store any Perl object in it.

Errors
======

In most circumstances, errors from libcurl functions will result in a
thrown X::LibCurl exception.  You can catch these with CATCH.  You can
see the string error, or cast to Int to see the [libcurl error
code](https://curl.haxx.se/libcurl/c/libcurl-errors.html).

As a special case, you might find the
[```failonerror```](https://curl.haxx.se/libcurl/c/CURLOPT_FAILONERROR.html)
option useful to force an error if the HTTP code is equal to or larger
than 400.

On an error, you may find [extra human readable error
messages](https://curl.haxx.se/libcurl/c/CURLOPT_ERRORBUFFER.html)
with the ```.error``` method:

    say $curl.error;

Info
====

After a transfer, you can retrieve internal information about the curl
session with the
```.getinfo```(https://curl.haxx.se/libcurl/c/curl_easy_getinfo.html)
method.

You can explicitly request a single field, or a list of fields to get
a hash, or just get all the fields as a hash.  As in the options,
there are also convenience methods for each info field.

    say $curl.getinfo('effective-url');
    say $curl.getinfo('response-code');

    say $curl.getinfo(<effective-url response-code>);  # Hash with those keys

    say $curl.getinfo;   # Hash of all info fields
   
    say $curl.effective-url;
    say $curl.response-code;

Fields currently defined are:

appconnect_time certinfo condition-unmet connect-time content-type
cookielist effective-url ftp-entry-path header-size http-connectcode
httpauth-avail lastsocket local-ip local-port namelookup-time
num-connects os-errno pretransfer-time primary-ip primary-port
proxyauth-avail redirect-url request-size response-code
rtsp-client-cseq rtsp-cseq-recv rtsp-server-cseq rtsp-session-id
size-download size-upload speed-download speed-upload ssl_engines
tls-session total-time

Received header fields
======================

You can retrieve the header fields in several ways as well.

    say $curl.receiveheaders<Content-Length>;  # Hash of all headers

    say $curl.get-header('Content-Length');

    say $curl.Content-Length;

Content
=======

If you did not specify the ```download``` option to download content
into a file, the content will be stashed in memory in a Buf object:

    say "Got binary content", $curl.buf;

If you understand that the content is decodable as a string, you can
call the ```.content($encoding = 'utf-8')``` which will decode the
content into a Str, by default with the *utf-8* encoding.

Multi
=====

Perl6 LibCurl also supports the libcurl
[multi](https://curl.haxx.se/libcurl/c/libcurl-multi.html) interface.
You still have to construct LibCurl::Easy (or LibCurl::HTTP) handles
for each transfer, but instead of calling ```.perform```, just add the
handle to a ```LibCurl::Multi```.

    use LibCurl::Easy;
    use LibCurl::Multi;

    my $curl1 = LibCurl::Easy.new(:verbose, :followlocation,
                         URL => 'http://example.com',
                         download => './myfile1.html');

    my $curl2 = LibCurl::Easy.new(:verbose, :followlocation,
                         URL => 'http://example.com',
                         download => './myfile2.html');

    my $multi = LibCurl:Multi.new;

    $multi.add-handle($curl1);
    $multi.add-handle($curl2);

    $multi.perform;

    say $curl1.statusline;
    say $curl2.statusline;

You can also use an asynchronous callback to get a notification when
an individual transfer has completed.  The callback takes place in the
same thread with all the transfers, so it should complete quickly (or
start a new thread for heavy lifting as needed).  You can add
additional handles to the ```LibCurl::Multi``` at any time, even
re-using completed LibCurl::Easy handles (after setting URL, etc. as
needed).

    use LibCurl::Easy;
    use LibCurl::Multi;

    my $curl1 = LibCurl::Easy.new(:followlocation,
                                  URL => 'http://example.com',
                                  download => 'myfile1.html');

    my $curl2 = LibCurl::Easy.new(:followlocation,
                                  URL => 'http://example.com',
                                  download => 'myfile2.html');

    sub callback(LibCurl::Easy $easy, Exception $e)
    {
        die $e if $e;
        say $easy.response-code;
        say $easy.statusline;
    }

    my $multi = LibCurl::Multi.new(callback => &callback);

    $multi.add-handle($curl1, $curl2);

    $multi.perform;


SEE ALSO
========

There is another Perl 6 interface to libcurl
[Net::Curl](https://github.com/azawawi/perl6-net-curl) developed by
Ahmad M. Zawawi.  If you already use it and it works well for you,
great, keep using it.  Ahmad did a nice job developing it.  I would
encourage you to also take a look at this module.  LibCurl provides a
more 'perlish' OO interface to libcurl than Net::Curl, and wraps
things in a manner to make using it a little easier (IMHO).

LICENSE
=======

Copyright © 2017 United States Government as represented by the
Administrator of the National Aeronautics and Space Administration.
No copyright is claimed in the United States under Title 17,
U.S.Code. All Other Rights Reserved.
