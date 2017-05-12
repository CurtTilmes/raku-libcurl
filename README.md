# Perl6 LibCurl

[![Build Status](https://travis-ci.org/CurtTilmes/perl6-libcurl.svg)](https://travis-ci.org/CurtTilmes/perl6-libcurl)


[Simple Examples](#simple-examples)
[Options](#options)
[Header Options](#header-options)
[Special Options](#special-options)
[Errors](#errors)
[Info](#info)
[Received headers](#received-header-fields)
[Content](#content)
[Proxies](#proxies)
[Multi](#multi)

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

## Simple Examples

    use LibCurl::Easy;

    # GET
    print LibCurl::Easy.new(URL => 'http://example.com').perform.content;
    
    # GET (download a file)
    LibCurl::Easy.new(URL => 'http://example.com/somefile',
                      download => 'somefile').perform;

    # HEAD
    say LibCurl::Easy.new(:nobody, URL => 'http://example.com')
        .perform.response-code;

    # PUT (upload a file)
    LibCurl::Easy.new(URL => 'http://example.com/somefile',
                      upload => 'somefile').perform;

    # PUT (content from a string)
    LibCurl::Easy.new(URL => 'http://example.com/somefile',
                      send => 'My Content').perform;

     # DELETE
    LibCurl::Easy.new(URL => 'http://example.com/file-to-delete',
                      customrequest => 'DELETE').perform;

    # POST
    LibCurl::Easy.new(URL => 'http://example.com/form.html',
                      postfields => 'name=foo&opt=value').perform;

## LibCurl::HTTP

If even those aren't easy enough, there is a tiny sub-class
**LibCurl::HTTP** that adds aliases for the common HTTP methods:

    use LibCurl::HTTP;

    my $http = LibCurl::HTTP.new;

    say $http.GET('http://example.com').perform.content;

    say $http.GET('http://example.com', 'myfile').perform.response-code;

    say $http.HEAD('http://example.com').perform.response-code;

    $http.DELETE('http://example.com').perform;

    $http.PUT('http://example.com', 'myfile').perform;

    $http.POST('http://example.com/form.html', 'name=foo&opt=value').perform;

LibCurl::HTTP methods also enable `failonerror` by default, so any
HTTP response >= 400 will throw an error.

You can even import very simple subroutines ala [WWW](https://github.com/zoffixznet/perl6-WWW):

    use LibCurl::HTTP :subs;

    # Just GET content (will return Failure on failure):
    say get 'https://httpbin.org/get?foo=42&bar=x';

    # GET and decode received data as JSON:
    say jget('https://httpbin.org/get?foo=42&bar=x')<args><foo>;

    # POST content (query args are OK; pass form as named args)
    say post 'https://httpbin.org/post?foo=42&bar=x', :some<form>, :42args;

    # And if you need headers, pass them inside a positional Hash:
    say post 'https://httpbin.org/post?foo=42&bar=x', %(:Some<Custom-Header>),
        :some<form>, :42args;

    # Same POST as above + decode response as JSON
    say jpost('https://httpbin.org/post', :some<form-arg>)<form><some>;

## Fancier Example

    my $curl = LibCurl::Easy.new(:verbose, :followlocation);
    $curl.setopt(URL => 'http://example.com', download => './myfile.html');
    $curl.perform;
    say $curl.Content-Type;
    say $curl.Content-Length;
    say $curl.Date;
    say $curl.response-code;
    say $curl.statusline;

Of course the full power of [libcurl](https://curl.haxx.se/libcurl) is
available, so you aren't limited to HTTP URLs, you can use FTP, SMTP,
TFTP, SCP, SFTP, and many, many more.

## Options

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

```postfields``` is actually
[CURLOPT_COPYPOSTFIELDS](https://curl.haxx.se/libcurl/c/CURLOPT_COPYPOSTFIELDS.html) so it will always copy the fields.

Some of the normal options have **_LARGE** versions.  LibCurl always
maps the option to the **_LARGE** option where they exist, so you
don't have to worry about overflows.

These are the current options (If you want one not in this list, let
me know):

[CAinfo](https://curl.haxx.se/libcurl/c/CURLOPT_CAINFO.html)
[CApath](https://curl.haxx.se/libcurl/c/CURLOPT_CAPATH.html)
[URL](https://curl.haxx.se/libcurl/c/CURLOPT_URL.html)
[accepttimeout-ms](https://curl.haxx.se/libcurl/c/CURLOPT_ACCEPTTIMEOUT_MS.html)
[accept-encoding](https://curl.haxx.se/libcurl/c/CURLOPT_ACCEPT_ENCODING.html)
[address-scope](https://curl.haxx.se/libcurl/c/CURLOPT_ADDRESS_SCOPE.html)
[append](https://curl.haxx.se/libcurl/c/CURLOPT_APPEND.html)
[autoreferer](https://curl.haxx.se/libcurl/c/CURLOPT_AUTOREFERER.html)
[buffersize](https://curl.haxx.se/libcurl/c/CURLOPT_BUFFERSIZE.html)
[certinfo](https://curl.haxx.se/libcurl/c/CURLOPT_CERTINFO.html)
[cookie](https://curl.haxx.se/libcurl/c/CURLOPT_COOKIE.html)
[cookiefile](https://curl.haxx.se/libcurl/c/CURLOPT_COOKIEFILE.html)
[cookiejar](https://curl.haxx.se/libcurl/c/CURLOPT_COOKIEJAR.html)
[cookielist](https://curl.haxx.se/libcurl/c/CURLOPT_COOKIELIST.html)
[customrequest](https://curl.haxx.se/libcurl/c/CURLOPT_CUSTOMREQUEST.html)
[dirlistonly](https://curl.haxx.se/libcurl/c/CURLOPT_DIRLISTONLY.html)
[failonerror](https://curl.haxx.se/libcurl/c/CURLOPT_FAILONERROR.html)
[followlocation](https://curl.haxx.se/libcurl/c/CURLOPT_FOLLOWLOCATION.html)
[forbid-reuse](https://curl.haxx.se/libcurl/c/CURLOPT_FORBID_REUSE.html)
[fresh-connect](https://curl.haxx.se/libcurl/c/CURLOPT_FRESH_CONNECT.html)
[ftp-skip-pasv-ip](https://curl.haxx.se/libcurl/c/CURLOPT_FTP_SKIP_PASV_IP.html)
[ftp-use-eprt](https://curl.haxx.se/libcurl/c/CURLOPT_FTP_USE_EPRT.html)
[ftp-use-epsv](https://curl.haxx.se/libcurl/c/CURLOPT_FTP_USE_EPSV.html)
[ftpport](https://curl.haxx.se/libcurl/c/CURLOPT_FTPPORT.html)
[header](https://curl.haxx.se/libcurl/c/CURLOPT_HEADER.html)
[http-version](https://curl.haxx.se/libcurl/c/CURLOPT_HTTP_VERSION.html)
[httpauth](https://curl.haxx.se/libcurl/c/CURLOPT_HTTPAUTH.html)
[httpget](https://curl.haxx.se/libcurl/c/CURLOPT_HTTPGET.html)
[httpproxytunnel](https://curl.haxx.se/libcurl/c/CURLOPT_HTTPPROXYTUNNEL.html)
[infilesize](https://curl.haxx.se/libcurl/c/CURLOPT_INFILESIZE_LARGE.html)
[low-speed-limit](https://curl.haxx.se/libcurl/c/CURLOPT_LOW_SPEED_LIMIT.html)
[low-speed-time](https://curl.haxx.se/libcurl/c/CURLOPT_LOW_SPEED_TIME.html)
[maxconnects](https://curl.haxx.se/libcurl/c/CURLOPT_MAXCONNECTS.html)
[maxfilesize](https://curl.haxx.se/libcurl/c/CURLOPT_MAXFILESIZE_LARGE.html)
[maxredirs](https://curl.haxx.se/libcurl/c/CURLOPT_MAXREDIRS.html)
[max-send-speed](https://curl.haxx.se/libcurl/c/CURLOPT_MAX_SEND_SPEED_LARGE.html)
[max-recv-speed](https://curl.haxx.se/libcurl/c/CURLOPT_MAX_RECV_SPEED_LARGE.html)
[netrc](https://curl.haxx.se/libcurl/c/CURLOPT_NETRC.html)
[nobody](https://curl.haxx.se/libcurl/c/CURLOPT_NOBODY.html)
[noprogress](https://curl.haxx.se/libcurl/c/CURLOPT_NOPROGRESS.html)
[nosignal](https://curl.haxx.se/libcurl/c/CURLOPT_NOSIGNAL.html)
[password](https://curl.haxx.se/libcurl/c/CURLOPT_PASSWORD.html)
[post](https://curl.haxx.se/libcurl/c/CURLOPT_POST.html)
[postfields](https://curl.haxx.se/libcurl/c/CURLOPT_COPYPOSTFIELDS.html)
[postfieldsize](https://curl.haxx.se/libcurl/c/CURLOPT_POSTFIELDSIZE_LARGE.html)
[protocols](https://curl.haxx.se/libcurl/c/CURLOPT_PROTOCOLS.html)
[proxy](https://curl.haxx.se/libcurl/c/CURLOPT_PROXY.html)
[proxyauth](https://curl.haxx.se/libcurl/c/CURLOPT_PROXYAUTH.html)
[proxyport](https://curl.haxx.se/libcurl/c/CURLOPT_PROXYPORT.html)
[proxytype](https://curl.haxx.se/libcurl/c/CURLOPT_PROXYTYPE.html)
[proxyuserpwd](https://curl.haxx.se/libcurl/c/CURLOPT_PROXYUSERPWD.html)
[range](https://curl.haxx.se/libcurl/c/CURLOPT_RANGE.html)
[redir-protocols](https://curl.haxx.se/libcurl/c/CURLOPT_REDIR_PROTOCOLS.html)
[referer](https://curl.haxx.se/libcurl/c/CURLOPT_REFERER.html)
[resume-from](https://curl.haxx.se/libcurl/c/CURLOPT_RESUME_FROM_LARGE.html)
[ssl-verifyhost](https://curl.haxx.se/libcurl/c/CURLOPT_SSL_VERIFYHOST.html)
[ssl-verifypeer](https://curl.haxx.se/libcurl/c/CURLOPT_SSL_VERIFYPEER.html)
[timecondition](https://curl.haxx.se/libcurl/c/CURLOPT_TIMECONDITION.html)
[timeout](https://curl.haxx.se/libcurl/c/CURLOPT_TIMEOUT.html)
[timeout-ms](https://curl.haxx.se/libcurl/c/CURLOPT_TIMEOUT_MS.html)
[timevalue](https://curl.haxx.se/libcurl/c/CURLOPT_TIMEVALUE.html)
[unrestricted-auth](https://curl.haxx.se/libcurl/c/CURLOPT_UNRESTRICTED_AUTH.html)
[use-ssl](https://curl.haxx.se/libcurl/c/CURLOPT_USE_SSL.html)
[useragent](https://curl.haxx.se/libcurl/c/CURLOPT_USERAGENT.html)
[username](https://curl.haxx.se/libcurl/c/CURLOPT_USERNAME.html)
[userpwd](https://curl.haxx.se/libcurl/c/CURLOPT_USERPWD.html)
[verbose](https://curl.haxx.se/libcurl/c/CURLOPT_VERBOSE.html)
[wildcardmatch](https://curl.haxx.se/libcurl/c/CURLOPT_WILDCARDMATCH.html)

## Header Options

In addition to the normal libcurl special options that set headers
([useragent](https://curl.haxx.se/libcurl/c/CURLOPT_USERAGENT.html),
[referer](https://curl.haxx.se/libcurl/c/CURLOPT_REFERER.html),
[cookie](https://curl.haxx.se/libcurl/c/CURLOPT_COOKIE.html)), there
are some extra options for headers:

`Content-MD5`, `Content-Type`, `Content-Length`, `Host`, `Accept`,
`Expect`, `Transfer-Encoding`.

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

## Special Options

In addition to the normal libcurl options, Perl6 LibCurl uses options
for some special Perl functionality.

```debugfunction``` replaces the libcurl
[CURLOPT_DEBUGFUNCTION](https://curl.haxx.se/libcurl/c/CURLOPT_DEBUGFUNCTION.html)
callback, with one that looks like this:

    sub debug(LibCurl::Easy $easy, CURL-INFO-TYPE $type, Buf $buf)
    {...}

    $curl.setopt(debugfunction => &debug);

```xferinfo``` replaces the libcurl
[CURLOPT_XFERINFOFUNCTION](https://curl.haxx.se/libcurl/c/CURLOPT_XFERINFOFUNCTION.html)
(and
[CURLOPT_PROGRESSFUNCTION](https://curl.haxx.se/libcurl/c/CURLOPT_PROGRESSFUNCTION.html))
with one that looks like this:

    sub xferinfo(LibCurl::Easy $easy, $dltotal, $dlnow, $ultotal, $ulnow)
    {...}

    $curl.setopt(xferinfofunction => &xferinfo);

```download``` specifies a filename to download into.

```upload``` specifies a filename to upload from.

```send``` specifies a Perl `Str` or a Perl `Buf` to send content from.

Finally there is a ```private``` option which replaces
CURLOPT_PRIVATE, and you can safely store any Perl object in it.

## Errors

In most circumstances, errors from libcurl functions will result in a
thrown X::LibCurl exception.  You can catch these with CATCH.  You can
see the string error, or cast to Int to see the [libcurl error
code](https://curl.haxx.se/libcurl/c/libcurl-errors.html).

You might find the
[failonerror](https://curl.haxx.se/libcurl/c/CURLOPT_FAILONERROR.html)
option useful to force an error if the HTTP code is equal to or larger
than 400.

On an error, you may find [extra human readable error
messages](https://curl.haxx.se/libcurl/c/CURLOPT_ERRORBUFFER.html)
with the ```.error``` method.

    $curl.perform;

    CATCH {
        say "Caught!";
        when X::LibCurl {
            say "$_.Int() : $_";
            say $curl.response-code;
            say $curl.error;
        }
    }

## Info

After a transfer, you can retrieve internal information about the curl
session with the
[.getinfo](https://curl.haxx.se/libcurl/c/curl_easy_getinfo.html)
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

[appconnect_time](https://curl.haxx.se/libcurl/c/CURLINFO_APPCONNECT_TIME.html)
[certinfo](https://curl.haxx.se/libcurl/c/CURLINFO_CERTINFO.html)
[condition-unmet](https://curl.haxx.se/libcurl/c/CURLINFO_CONDITION_UNMET.html)
[connect-time](https://curl.haxx.se/libcurl/c/CURLINFO_CONNECT_TIME.html)
[content-type](https://curl.haxx.se/libcurl/c/CURLINFO_CONTENT_TYPE.html)
[cookielist](https://curl.haxx.se/libcurl/c/CURLINFO_COOKIELIST.html)
[effective-url](https://curl.haxx.se/libcurl/c/CURLINFO_EFFECTIVE_URL.html)
[ftp-entry-path](https://curl.haxx.se/libcurl/c/CURLINFO_FTP_ENTRY_PATH.html)
[header-size](https://curl.haxx.se/libcurl/c/CURLINFO_HEADER_SIZE.html)
[http-connectcode](https://curl.haxx.se/libcurl/c/CURLINFO_HTTP_CONNECTCODE.html)
[httpauth-avail](https://curl.haxx.se/libcurl/c/CURLINFO_HTTPAUTH_AVAIL.html)
[lastsocket](https://curl.haxx.se/libcurl/c/CURLINFO_LASTSOCKET.html)
[local-ip](https://curl.haxx.se/libcurl/c/CURLINFO_LOCAL_IP.html)
[local-port](https://curl.haxx.se/libcurl/c/CURLINFO_LOCAL_PORT.html)
[namelookup-time](https://curl.haxx.se/libcurl/c/CURLINFO_NAMELOOKUP_TIME.html)
[num-connects](https://curl.haxx.se/libcurl/c/CURLINFO_NUM_CONNECTS.html)
[os-errno](https://curl.haxx.se/libcurl/c/CURLINFO_OS_ERRNO.html)
[pretransfer-time](https://curl.haxx.se/libcurl/c/CURLINFO_PRETRANSFER_TIME.html)
[primary-ip](https://curl.haxx.se/libcurl/c/CURLINFO_PRIMARY_IP.html)
[primary-port](https://curl.haxx.se/libcurl/c/CURLINFO_PRIMARY_PORT.html)
[proxyauth-avail](https://curl.haxx.se/libcurl/c/CURLINFO_PROXYAUTH_AVAIL.html)
[redirect-url](https://curl.haxx.se/libcurl/c/CURLINFO_REDIRECT_URL.html)
[request-size](https://curl.haxx.se/libcurl/c/CURLINFO_REQUEST_SIZE.html)
[response-code](https://curl.haxx.se/libcurl/c/CURLINFO_RESPONSE_CODE.html)
[rtsp-client-cseq](https://curl.haxx.se/libcurl/c/CURLINFO_RTSP_CLIENT_CSEQ.html)
[rtsp-cseq-recv](https://curl.haxx.se/libcurl/c/CURLINFO_RTSP_CSEQ_RECV.html)
[rtsp-server-cseq](https://curl.haxx.se/libcurl/c/CURLINFO_RTSP_SERVER_CSEQ.html)
[rtsp-session-id](https://curl.haxx.se/libcurl/c/CURLINFO_RTSP_SESSION_ID.html)
[size-download](https://curl.haxx.se/libcurl/c/CURLINFO_SIZE_DOWNLOAD.html)
[size-upload](https://curl.haxx.se/libcurl/c/CURLINFO_SIZE_UPLOAD.html)
[speed-download](https://curl.haxx.se/libcurl/c/CURLINFO_SPEED_DOWNLOAD.html)
[speed-upload](https://curl.haxx.se/libcurl/c/CURLINFO_SPEED_UPLOAD.html)
[ssl-engines](https://curl.haxx.se/libcurl/c/CURLINFO_SSL_ENGINES.html)
[total-time](https://curl.haxx.se/libcurl/c/CURLINFO_TOTAL_TIME.html)

## Received header fields

You can retrieve the header fields in several ways as well.

    say $curl.receiveheaders<Content-Length>;  # Hash of all headers

    say $curl.get-header('Content-Length');

    say $curl.Content-Length;

## Content

If you did not specify the ```download``` option to download content
into a file, the content will be stashed in memory in a Buf object you
can access with the `.buf()` method.

If you understand that the content is decodable as a string, you can
call the ```.content($encoding = 'utf-8')``` method which will decode
the content into a `Str`, by default with the **utf-8** encoding if
not specified.

    say "Got content", $curl.content;

## Multi-part forms

There is a special POST option for multipart/formdata.

    my $curl = LibCurl::Easy.new(URL => 'http://...');

    # normal field
    $curl.formadd(name => 'fieldname', contents => 'something');

    # upload a file from disk, give optional filename or contenttype
    $curl.formadd(name => 'fieldname', file => 'afile.txt',
                  filename => 'alternate.name.txt',
                  contenttype => 'image/jpeg');

    # Send a Blob of contents, but as a file with a filename
    $curl.formadd(name => 'fieldname', buffer => 'some.file.name.txt',
                  bufferptr => "something".encode);

    $curl.perform;

This will automatically cause LibCurl to POST the data.

The options are described in more detail [here](https://curl.haxx.se/libcurl/c/curl_formadd.html).

The fields implemented are:

[name](https://curl.haxx.se/libcurl/c/curl_formadd.html#CURLFORMCOPYNAME)
[contents](https://curl.haxx.se/libcurl/c/curl_formadd.html#CURLFORMCOPYCONTENTS)
[filecontent](https://curl.haxx.se/libcurl/c/curl_formadd.html#CURLFORMFILECONTENT)
[file](https://curl.haxx.se/libcurl/c/curl_formadd.html#CURLFORMFILE)
[contenttype](https://curl.haxx.se/libcurl/c/curl_formadd.html#CURLFORMCONTENTTYPE)
[filename](https://curl.haxx.se/libcurl/c/curl_formadd.html#CURLFORMFILENAME)
[buffer](https://curl.haxx.se/libcurl/c/curl_formadd.html#CURLFORMBUFFER)
[bufferptr](https://curl.haxx.se/libcurl/c/curl_formadd.html#CURLFORMBUFFERPTR)

## Proxies

[libcurl](https://curl.haxx.se/libcurl) has great proxy support, and
you should be able to specify anything needed as options to LibCurl to
use them.  The easiest for most common cases is to just set the
[proxy](https://curl.haxx.se/libcurl/c/CURLOPT_PROXY.html) option.

By default, libcurl will also respect the environment variables
**http_proxy**, **ftp_proxy**, **all_proxy**, etc. if any of those are
set.  Setting the `proxy` string to `""` (an empty string) will
explicitly disable the use of a proxy, even if there is an environment
variable set for it.

A proxy host string can also include protocol scheme (`http://`) and
embedded user + password.

## Multi

Perl6 LibCurl also supports the libcurl
[multi](https://curl.haxx.se/libcurl/c/libcurl-multi.html) interface.
You still have to construct `LibCurl::Easy` (or `LibCurl::HTTP`)
handles for each transfer, but instead of calling `.perform`, just add
the handle to a `LibCurl::Multi`.

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
additional handles to the `LibCurl::Multi` at any time, even re-using
completed LibCurl::Easy handles (after setting `URL`, etc. as needed).

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

## INSTALL

`LibCurl` depends on [libcurl](https://curl.haxx.se/download.html), so
you must install that prior to installing this module.

## SEE ALSO

There is another Perl 6 interface to libcurl
[Net::Curl](https://github.com/azawawi/perl6-net-curl) developed by
Ahmad M. Zawawi.  If you already use it and it works well for you,
great, keep using it.  Ahmad did a nice job developing it.  I would
encourage you to also take a look at this module.  LibCurl provides a
more 'perlish' OO interface to libcurl than Net::Curl, and wraps
things in a manner to make using it a little easier (IMHO).

## LICENSE

Copyright © 2017 United States Government as represented by the
Administrator of the National Aeronautics and Space Administration.
No copyright is claimed in the United States under Title 17,
U.S.Code. All Other Rights Reserved.

See [NASA Open Source Agreement](../master/NASA_Open_Source_Agreement_1.3%20GSC-17847.pdf) for more details.
