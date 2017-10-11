use v6;

use NativeCall;
use LibCurl::EasyHandle;

my %allhandles;
my $allhandles-lock = Lock.new;

# Re-export symbols user might want from EasyHandle
my package EXPORT::DEFAULT { }
BEGIN for <

    CURLE_OK
    CURLE_UNSUPPORTED_PROTOCOL
    CURLE_FAILED_INIT
    CURLE_URL_MALFORMAT
    CURLE_NOT_BUILT_IN
    CURLE_COULDNT_RESOLVE_PROXY
    CURLE_COULDNT_RESOLVE_HOST
    CURLE_COULDNT_CONNECT
    CURLE_FTP_WEIRD_SERVER_REPLY
    CURLE_REMOTE_ACCESS_DENIED
    CURLE_FTP_ACCEPT_FAILED
    CURLE_FTP_WEIRD_PASS_REPLY
    CURLE_FTP_ACCEPT_TIMEOUT
    CURLE_FTP_WEIRD_PASV_REPLY
    CURLE_FTP_WEIRD_227_FORMAT
    CURLE_FTP_CANT_GET_HOST
    CURLE_OBSOLETE16
    CURLE_FTP_COULDNT_SET_TYPE
    CURLE_PARTIAL_FILE
    CURLE_FTP_COULDNT_RETR_FILE
    CURLE_OBSOLETE20
    CURLE_QUOTE_ERROR
    CURLE_HTTP_RETURNED_ERROR
    CURLE_WRITE_ERROR
    CURLE_OBSOLETE24
    CURLE_UPLOAD_FAILED
    CURLE_READ_ERROR
    CURLE_OUT_OF_MEMORY
    CURLE_OPERATION_TIMEDOUT
    CURLE_OBSOLETE29
    CURLE_FTP_PORT_FAILED
    CURLE_FTP_COULDNT_USE_REST
    CURLE_OBSOLETE32
    CURLE_RANGE_ERROR
    CURLE_HTTP_POST_ERROR
    CURLE_SSL_CONNECT_ERROR
    CURLE_BAD_DOWNLOAD_RESUME
    CURLE_FILE_COULDNT_READ_FILE
    CURLE_LDAP_CANNOT_BIND
    CURLE_LDAP_SEARCH_FAILED
    CURLE_OBSOLETE40
    CURLE_FUNCTION_NOT_FOUND
    CURLE_ABORTED_BY_CALLBACK
    CURLE_BAD_FUNCTION_ARGUMENT
    CURLE_OBSOLETE44
    CURLE_INTERFACE_FAILED
    CURLE_OBSOLETE46
    CURLE_TOO_MANY_REDIRECTS
    CURLE_UNKNOWN_OPTION
    CURLE_TELNET_OPTION_SYNTAX
    CURLE_OBSOLETE50
    CURLE_PEER_FAILED_VERIFICATION
    CURLE_GOT_NOTHING
    CURLE_SSL_ENGINE_NOTFOUND
    CURLE_SSL_ENGINE_SETFAILED
    CURLE_SEND_ERROR
    CURLE_RECV_ERROR
    CURLE_OBSOLETE57
    CURLE_SSL_CERTPROBLEM
    CURLE_SSL_CIPHER
    CURLE_SSL_CACERT
    CURLE_BAD_CONTENT_ENCODING
    CURLE_LDAP_INVALID_URL
    CURLE_FILESIZE_EXCEEDED
    CURLE_USE_SSL_FAILED
    CURLE_SEND_FAIL_REWIND
    CURLE_SSL_ENGINE_INITFAILED
    CURLE_LOGIN_DENIED
    CURLE_TFTP_NOTFOUND
    CURLE_TFTP_PERM
    CURLE_REMOTE_DISK_FULL
    CURLE_TFTP_ILLEGAL
    CURLE_TFTP_UNKNOWNID
    CURLE_REMOTE_FILE_EXISTS
    CURLE_TFTP_NOSUCHUSER
    CURLE_CONV_FAILED
    CURLE_CONV_REQD
    CURLE_SSL_CACERT_BADFILE
    CURLE_REMOTE_FILE_NOT_FOUND
    CURLE_SSH
    CURLE_SSL_SHUTDOWN_FAILED
    CURLE_AGAIN
    CURLE_SSL_CRL_BADFILE
    CURLE_SSL_ISSUER_ERROR
    CURLE_FTP_PRET_FAILED
    CURLE_RTSP_CSEQ_ERROR
    CURLE_RTSP_SESSION_ERROR
    CURLE_FTP_BAD_FILE_LIST
    CURLE_CHUNK_FAILED
    CURLE_NO_CONNECTION_AVAILABLE

    CURL_HTTP_VERSION_NONE
    CURL_HTTP_VERSION_1_0
    CURL_HTTP_VERSION_1_1
    CURL_HTTP_VERSION_2_0

    CURLINFO_TEXT
    CURLINFO_HEADER_IN
    CURLINFO_HEADER_OUT
    CURLINFO_DATA_IN
    CURLINFO_DATA_OUT
    CURLINFO_SSL_DATA_IN
    CURLINFO_SSL_DATA_OUT

    CURLAUTH_NONE
    CURLAUTH_BASIC
    CURLAUTH_DIGEST
    CURLAUTH_GSSNEGOTIATE
    CURLAUTH_NTLM
    CURLAUTH_DIGEST_IE
    CURLAUTH_NTLM_WB
    CURLAUTH_ONLY
    CURLAUTH_ANY
    CURLAUTH_ANYSAFE

    CURL_NETRC_IGNORED
    CURL_NETRC_OPTIONAL
    CURL_NETRC_REQUIRED

    CURL_TIMECOND_NONE
    CURL_TIMECOND_IFMODSINCE
    CURL_TIMECOND_IFUNMODSINCE
    CURL_TIMECOND_LASTMOD

    CURLPROXY_HTTP
    CURLPROXY_HTTP_1_0
    CURLPROXY_SOCKS4
    CURLPROXY_SOCKS5
    CURLPROXY_SOCKS4A
    CURLPROXY_SOCKS5_HOSTNAME

    CURLUSESSL_NONE
    CURLUSESSL_TRY
    CURLUSESSL_CONTROL
    CURLUSESSL_ALL

> { EXPORT::DEFAULT::{$_} = ::($_) }

enum CURLOPT_TYPE <CURLOPT_BOOL CURLOPT_STR CURLOPT_LONG CURLOPT_OFF_T
    LIBCURL_HEADER LIBCURL_DOWNLOAD LIBCURL_UPLOAD LIBCURL_SEND
    LIBCURL_DEBUG LIBCURL_XFER LIBCURL_PRIVATE>;

my %opts =
    CAinfo               => (CURLOPT_CAINFO,               CURLOPT_STR      ),
    CApath               => (CURLOPT_CAPATH,               CURLOPT_STR      ),
    URL                  => (CURLOPT_URL,                  CURLOPT_STR      ),
    accepttimeout-ms     => (CURLOPT_ACCEPTTIMEOUT_MS,     CURLOPT_LONG     ),
    accept-encoding      => (CURLOPT_ACCEPT_ENCODING,      CURLOPT_STR      ),
    address-scope        => (CURLOPT_ADDRESS_SCOPE,        CURLOPT_LONG     ),
    append               => (CURLOPT_APPEND,               CURLOPT_BOOL     ),
    autoreferer          => (CURLOPT_AUTOREFERER,          CURLOPT_BOOL     ),
    buffersize           => (CURLOPT_BUFFERSIZE,           CURLOPT_LONG     ),
    certinfo             => (CURLOPT_CERTINFO,             CURLOPT_BOOL     ),
    cookie               => (CURLOPT_COOKIE,               CURLOPT_STR      ),
    cookiefile           => (CURLOPT_COOKIEFILE,           CURLOPT_STR      ),
    cookiejar            => (CURLOPT_COOKIEJAR,            CURLOPT_STR      ),
    cookielist           => (CURLOPT_COOKIELIST,           CURLOPT_STR      ),
    customrequest        => (CURLOPT_CUSTOMREQUEST,        CURLOPT_STR      ),
    dirlistonly          => (CURLOPT_DIRLISTONLY,          CURLOPT_BOOL     ),
    failonerror          => (CURLOPT_FAILONERROR,          CURLOPT_BOOL     ),
    followlocation       => (CURLOPT_FOLLOWLOCATION,       CURLOPT_BOOL     ),
    forbid-reuse         => (CURLOPT_FORBID_REUSE,         CURLOPT_BOOL     ),
    fresh-connect        => (CURLOPT_FRESH_CONNECT,        CURLOPT_BOOL     ),
    ftp-skip-pasv-ip     => (CURLOPT_FTP_SKIP_PASV_IP,     CURLOPT_BOOL     ),
    ftp-use-eprt         => (CURLOPT_FTP_USE_EPRT,         CURLOPT_BOOL     ),
    ftp-use-epsv         => (CURLOPT_FTP_USE_EPSV,         CURLOPT_LONG     ),
    ftpport              => (CURLOPT_FTPPORT,              CURLOPT_STR      ),
    header               => (CURLOPT_HEADER,               CURLOPT_BOOL     ),
    http-version         => (CURLOPT_HTTP_VERSION,         CURLOPT_LONG     ),
    httpauth             => (CURLOPT_HTTPAUTH,             CURLOPT_LONG     ),
    httpget              => (CURLOPT_HTTPGET,              CURLOPT_BOOL     ),
    httpproxytunnel      => (CURLOPT_HTTPPROXYTUNNEL,      CURLOPT_BOOL     ),
    infilesize           => (CURLOPT_INFILESIZE_LARGE,     CURLOPT_OFF_T    ),
    low-speed-limit      => (CURLOPT_LOW_SPEED_LIMIT,      CURLOPT_LONG     ),
    low-speed-time       => (CURLOPT_LOW_SPEED_TIME,       CURLOPT_LONG     ),
    maxconnects          => (CURLOPT_MAXCONNECTS,          CURLOPT_LONG     ),
    maxfilesize          => (CURLOPT_MAXFILESIZE_LARGE,    CURLOPT_OFF_T    ),
    maxredirs            => (CURLOPT_MAXREDIRS,            CURLOPT_LONG     ),
    max-send-speed       => (CURLOPT_MAX_SEND_SPEED_LARGE, CURLOPT_OFF_T    ),
    max-recv-speed       => (CURLOPT_MAX_RECV_SPEED_LARGE, CURLOPT_OFF_T    ),
    netrc                => (CURLOPT_NETRC,                CURLOPT_LONG     ),
    nobody               => (CURLOPT_NOBODY,               CURLOPT_BOOL     ),
    noprogress           => (CURLOPT_NOPROGRESS,           CURLOPT_BOOL     ),
    nosignal             => (CURLOPT_NOSIGNAL,             CURLOPT_BOOL     ),
    password             => (CURLOPT_PASSWORD,             CURLOPT_STR      ),
    post                 => (CURLOPT_POST,                 CURLOPT_BOOL     ),
    postfields           => (CURLOPT_COPYPOSTFIELDS,       CURLOPT_STR      ),
    postfieldsize        => (CURLOPT_POSTFIELDSIZE_LARGE,  CURLOPT_OFF_T    ),
    protocols            => (CURLOPT_PROTOCOLS,            CURLOPT_LONG     ),
    proxy                => (CURLOPT_PROXY,                CURLOPT_STR      ),
    proxyauth            => (CURLOPT_PROXYAUTH,            CURLOPT_LONG     ),
    proxyport            => (CURLOPT_PROXYPORT,            CURLOPT_LONG     ),
    proxytype            => (CURLOPT_PROXYTYPE,            CURLOPT_LONG     ),
    proxyuserpwd         => (CURLOPT_PROXYUSERPWD,         CURLOPT_STR      ),
    range                => (CURLOPT_RANGE,                CURLOPT_STR      ),
    redir-protocols      => (CURLOPT_REDIR_PROTOCOLS,      CURLOPT_LONG     ),
    referer              => (CURLOPT_REFERER,              CURLOPT_STR      ),
    resume-from          => (CURLOPT_RESUME_FROM_LARGE,    CURLOPT_OFF_T    ),
    ssl-verifyhost       => (CURLOPT_SSL_VERIFYHOST,       CURLOPT_LONG     ),
    ssl-verifypeer       => (CURLOPT_SSL_VERIFYPEER,       CURLOPT_BOOL     ),
    timecondition        => (CURLOPT_TIMECONDITION,        CURLOPT_LONG     ),
    timeout              => (CURLOPT_TIMEOUT,              CURLOPT_LONG     ),
    timeout-ms           => (CURLOPT_TIMEOUT_MS,           CURLOPT_LONG     ),
    timevalue            => (CURLOPT_TIMEVALUE,            CURLOPT_LONG     ),
    unrestricted-auth    => (CURLOPT_UNRESTRICTED_AUTH,    CURLOPT_BOOL     ),
    use-ssl              => (CURLOPT_USE_SSL,              CURLOPT_LONG     ),
    useragent            => (CURLOPT_USERAGENT,            CURLOPT_STR      ),
    username             => (CURLOPT_USERNAME,             CURLOPT_STR      ),
    userpwd              => (CURLOPT_USERPWD,              CURLOPT_STR      ),
    verbose              => (CURLOPT_VERBOSE,              CURLOPT_BOOL     ),
    wildcardmatch        => (CURLOPT_WILDCARDMATCH,        CURLOPT_BOOL     ),
    Transfer-Encoding    => (0,                            LIBCURL_HEADER   ),
    Content-MD5          => (0,                            LIBCURL_HEADER   ),
    Content-Type         => (0,                            LIBCURL_HEADER   ),
    Content-Length       => (0,                            LIBCURL_HEADER   ),
    Host                 => (0,                            LIBCURL_HEADER   ),
    Accept               => (0,                            LIBCURL_HEADER   ),
    Expect               => (0,                            LIBCURL_HEADER   ),
    download             => (0,                            LIBCURL_DOWNLOAD ),
    upload               => (0,                            LIBCURL_UPLOAD   ),
    send                 => (0,                            LIBCURL_SEND     ),
    debugfunction        => (0,                            LIBCURL_DEBUG    ),
    xferinfofunction     => (0,                            LIBCURL_XFER     ),
    private              => (0,                            LIBCURL_PRIVATE  ),
;

my %infofields =
    appconnect_time      => (CURLINFO_APPCONNECT_TIME,  CURLINFO_DOUBLE     ),
    certinfo             => (CURLINFO_CERTINFO,         CURLINFO_SLIST      ),
    condition-unmet      => (CURLINFO_CONDITION_UNMET,  CURLINFO_LONG       ),
    connect-time         => (CURLINFO_CONNECT_TIME,     CURLINFO_DOUBLE     ),
    content-type         => (CURLINFO_CONTENT_TYPE,     CURLINFO_STRING     ),
    cookielist           => (CURLINFO_COOKIELIST,       CURLINFO_SLIST      ),
    effective-url        => (CURLINFO_EFFECTIVE_URL,    CURLINFO_STRING     ),
    ftp-entry-path       => (CURLINFO_FTP_ENTRY_PATH,   CURLINFO_STRING     ),
    header-size          => (CURLINFO_HEADER_SIZE,      CURLINFO_LONG       ),
    http-connectcode     => (CURLINFO_HTTP_CONNECTCODE, CURLINFO_LONG       ),
    httpauth-avail       => (CURLINFO_HTTPAUTH_AVAIL,   CURLINFO_LONG       ),
    lastsocket           => (CURLINFO_LASTSOCKET,       CURLINFO_LONG       ),
    local-ip             => (CURLINFO_LOCAL_IP,         CURLINFO_STRING     ),
    local-port           => (CURLINFO_LOCAL_PORT,       CURLINFO_LONG       ),
    namelookup-time      => (CURLINFO_NAMELOOKUP_TIME,  CURLINFO_DOUBLE     ),
    num-connects         => (CURLINFO_NUM_CONNECTS,     CURLINFO_LONG       ),
    os-errno             => (CURLINFO_OS_ERRNO,         CURLINFO_LONG       ),
    pretransfer-time     => (CURLINFO_PRETRANSFER_TIME, CURLINFO_DOUBLE     ),
    primary-ip           => (CURLINFO_PRIMARY_IP,       CURLINFO_STRING     ),
    primary-port         => (CURLINFO_PRIMARY_PORT,     CURLINFO_LONG       ),
    proxyauth-avail      => (CURLINFO_PROXYAUTH_AVAIL,  CURLINFO_LONG       ),
    redirect-url         => (CURLINFO_REDIRECT_URL,     CURLINFO_STRING     ),
    request-size         => (CURLINFO_REQUEST_SIZE,     CURLINFO_LONG       ),
    response-code        => (CURLINFO_RESPONSE_CODE,    CURLINFO_LONG       ),
    rtsp-client-cseq     => (CURLINFO_RTSP_CLIENT_CSEQ, CURLINFO_LONG       ),
    rtsp-cseq-recv       => (CURLINFO_RTSP_CSEQ_RECV,   CURLINFO_LONG       ),
    rtsp-server-cseq     => (CURLINFO_RTSP_SERVER_CSEQ, CURLINFO_LONG       ),
    rtsp-session-id      => (CURLINFO_RTSP_SESSION_ID,  CURLINFO_STRING     ),
    size-download        => (CURLINFO_SIZE_DOWNLOAD,    CURLINFO_DOUBLE     ),
    size-upload          => (CURLINFO_SIZE_UPLOAD,      CURLINFO_DOUBLE     ),
    speed-download       => (CURLINFO_SPEED_DOWNLOAD,   CURLINFO_DOUBLE     ),
    speed-upload         => (CURLINFO_SPEED_UPLOAD,     CURLINFO_DOUBLE     ),
    ssl-engines          => (CURLINFO_SSL_ENGINES,      CURLINFO_SLIST      ),
    total-time           => (CURLINFO_TOTAL_TIME,       CURLINFO_DOUBLE     ),
;

my %formfields =
    name        => (CURLFORM_COPYNAME,     CURLFORM_NAMELENGTH),
    contents    => (CURLFORM_COPYCONTENTS, CURLFORM_CONTENTSLENGTH),
    filecontent => (CURLFORM_FILECONTENT,  0),
    file        => (CURLFORM_FILE,         0),
    contenttype => (CURLFORM_CONTENTTYPE,  0),
    filename    => (CURLFORM_FILENAME,     0),
    buffer      => (CURLFORM_BUFFER,       0),
    bufferptr   => (CURLFORM_BUFFERPTR,    CURLFORM_BUFFERLENGTH),
;

INIT { curl_global_init(CURL_GLOBAL_DEFAULT) }

END { curl_global_cleanup() }

sub easy-lookup(Pointer $handleptr)
{
    %allhandles{nativecast(LibCurl::EasyHandle, $handleptr).id}
}

sub headerfunction(Pointer $ptr, uint32 $size, uint32 $nitems,
                   Pointer $handleptr) returns uint32
{
    my $easy = easy-lookup($handleptr);

    my $header = Blob.new(
        nativecast(CArray[uint8], $ptr)[0 ..^ $size * $nitems]
    ).decode;

    if $header ~~ /^HTTP\//
    {
        $easy.statusline = $header.trim;
    }
    elsif $header ~~ /^(<-[:]>+) ': ' (.*)$/
    {
        $easy.receiveheaders{$0} = $1.trim;
    }

    return $size * $nitems;
}

sub memcpy(Pointer $dest, Blob, uint32 $n) is native { * }

sub readfunction(Pointer $ptr, uint32 $size, uint32 $nmemb,
                        Pointer $handleptr) returns uint32
{
    my $easy = easy-lookup($handleptr);

    return 0 if $easy.sendindex >= $easy.sendbuf.elems;

    my $tosend = min $easy.sendbuf.elems - $easy.sendindex, $size * $nmemb;

    memcpy($ptr, $easy.sendbuf.subbuf($easy.sendindex, $tosend), $tosend);

    $easy.sendindex += $tosend;

    return $tosend;
}

sub writefunction(Pointer $ptr, uint32 $size, uint32 $nmemb,
                      Pointer $handleptr) returns uint32
{
    my $easy = easy-lookup($handleptr);

    $easy.buf ~= Blob.new(
        nativecast(CArray[uint8], $ptr)[0 ..^ $size * $nmemb]
    );

    return $size * $nmemb;
}

sub debugfunction(Pointer $handleptr, uint32 $type, Pointer $data, size_t $size,
    Pointer $userptr)
{
    my $easy = easy-lookup($handleptr);

    $easy.debugfunction.($easy, CURL-INFO-TYPE($type),
                         Buf.new(nativecast(CArray[int8], $data)[0 ..^ $size]));
}

sub xferinfofunction(Pointer $handleptr, long $dltotal, long $dlnow,
		     long $ultotal, long $ulnow)
{
    my $easy = easy-lookup($handleptr);

    $easy.xferinfofunction.($easy, $dltotal.Int, $dlnow.Int,
                                   $ultotal.Int, $ulnow.Int);
}

class LibCurl::Easy
{
    has LibCurl::EasyHandle $.handle handles <escape unescape>;
    has LibCurl::slist $.header-slist;
    has LibCurl::Form $.form;
    has %.receiveheaders is rw;
    has $.statusline is rw;
    has Pointer $.upload-fh;
    has Pointer $.download-fh;
    has Blob $.sendbuf;
    has Int $.sendindex is rw;
    has Blob $.buf is rw;
    has $.errorbuffer;
    has &.debugfunction;
    has &.xferinfofunction;
    has $.private;

    sub fopen(Str $path, Str $mode) returns Pointer is native { * }

    sub fclose(Pointer $fp) returns int32 is native { * }

    sub fseek(Pointer $fp, long $offset, int32 $whence) is native { * }

    method new(|opts)
    {
        my $handle = LibCurl::EasyHandle.new;
        my $errorbuffer = CArray[uint8].new;
        $errorbuffer[0] = 0;
        $errorbuffer[CURL_ERROR_SIZE] = 0;
        my $self = self.bless(:$handle, :$errorbuffer);
        $allhandles-lock.protect({ %allhandles{$handle.id} = $self });
        $handle.setopt(CURLOPT_HEADERDATA, $handle);
        $handle.setopt(CURLOPT_HEADERFUNCTION, &headerfunction);
        $handle.setopt(CURLOPT_ERRORBUFFER, $errorbuffer);
        $self.setopt(|opts);
        return $self;
    }

    method version returns Str { state $v = curl_version }

    method version-info returns LibCurl::version-info
    {
        state $v = LibCurl::version.new.info
    }

    method content($encoding is copy = 'utf-8') returns Str
    {
        with self.receiveheaders<Content-Type>
        {
            # Should be a stricter grammar, but dump regex will work for now
            if /charset \s* '=' \s* \\? <['"]>? (<-[\\"']>*) \\? <['"]>? /
            {
                $encoding = $0.Str;
            }
        }
        $!buf.decode($encoding)
    }

    method error() returns Str { nativecast(Str, $!errorbuffer) }

    method get-header(Str $field) { %!receiveheaders{$field} }

    method setopt(*%options)
    {
        for %options.kv -> $option, $param
        {
            die "Unknown option $option" unless %opts{$option};

            my ($code, $type) = %opts{$option};

            given $type
            {
                when CURLOPT_BOOL {
                    $!handle.setopt($code, $param ?? 1 !! 0);
                }

                when CURLOPT_LONG | CURLOPT_STR | CURLOPT_OFF_T {
                    $!handle.setopt($code, $param);

                    if $code == CURLOPT_RESUME_FROM_LARGE && $!upload-fh
                    {
                        fseek($!upload-fh, $param, 0);
                    }
                }

                when LIBCURL_HEADER {
                    self.set-header(|($option => $param));
                }

                when LIBCURL_DOWNLOAD {
                    $!download-fh = fopen($param, "wb");
                    $!handle.setopt(CURLOPT_WRITEDATA, $!download-fh);
                }

                when LIBCURL_UPLOAD {
                    $!upload-fh = fopen($param, "rb");
                    $!handle.setopt(CURLOPT_UPLOAD, 1);
                    $!handle.setopt(CURLOPT_INFILESIZE_LARGE,
                                         IO::Path.new($param).s);
                    $!handle.setopt(CURLOPT_READDATA, $!upload-fh);
                }

                when LIBCURL_SEND {
                    given $param {
                        when Buf { $!sendbuf = $param }
                        when Str { $!sendbuf = $param.encode }
                        default  { die "Don't know how to send $param" }
                    }
                    $!sendindex = 0;
                    $!handle.setopt(CURLOPT_UPLOAD, 1);
                    $!handle.setopt(CURLOPT_INFILESIZE_LARGE, $!sendbuf.elems);
                    $!handle.setopt(CURLOPT_READDATA, $!handle);
                    $!handle.setopt(CURLOPT_READFUNCTION, &readfunction);
                }

		when LIBCURL_DEBUG {
                    &!debugfunction = $param;
		    $!handle.setopt(CURLOPT_DEBUGFUNCTION, &debugfunction);
		    $!handle.setopt(CURLOPT_VERBOSE, 1);
		}

                when LIBCURL_XFER {
                    &!xferinfofunction = $param;
                    $!handle.setopt(CURLOPT_XFERINFODATA, $!handle);
                    $!handle.setopt(CURLOPT_XFERINFOFUNCTION,
                                    &xferinfofunction);
                    $!handle.setopt(CURLOPT_NOPROGRESS, 0);
                }

                when LIBCURL_PRIVATE {
                    $!private = $param;
                }

                default {
                    die "Unknown option $option";
                }
            }
        }
        return self;
    }

    method clear-header()
    {
        $!header-slist.free if $!header-slist;
        $!header-slist = LibCurl::slist;
	return self;
    }

    method set-header(*%headers)
    {
        for %headers.kv -> $field, $value
        {
            $!header-slist = $!header-slist.append(
                $value eq ';' ?? "$field;" !! "$field: $value"
            );
        }

        return self;
    }

    method formadd(*%fields)
    {
        $!form //= LibCurl::Form.new;

        my @form-array;

        for %fields.kv -> $field, $param
        {
            die "Unknown form field option $field" unless %formfields{$field};

            my ($code, $codelength) = %formfields{$field};

            my $blob = $param ~~ Blob ?? $param !! "$param\0".encode;

            @form-array.push: ($code, $blob);

            if $codelength
            {
                @form-array.push: ($codelength, $blob.elems);
            }
        }

        $!form.add-array(@form-array);

        return self;
    }

    method clear-form()
    {
        .free with $!form;
        $!form = LibCurl::Form;
    }

    method prepare()
    {
        $!handle.setopt(CURLOPT_HTTPHEADER, $!header-slist);

        unless $!download-fh
        {
            $!buf = Buf.new;
            $!handle.setopt(CURLOPT_WRITEDATA, $!handle);
            $!handle.setopt(CURLOPT_WRITEFUNCTION, &writefunction);
        }

        $!handle.setopt(CURLOPT_HTTPPOST, $!form.firstitem) if $!form;

        %!receiveheaders = ();
    }

    method finish()
    {
        if $!download-fh {
            fclose($!download-fh);
            $!download-fh = Pointer;
        }
        if $!upload-fh {
            fclose($!upload-fh);
            $!upload-fh = Pointer;
        }
    }

    method perform() returns LibCurl::Easy
    {
        self.prepare;

        my $ret = $!handle.perform;

        self.finish;

        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;

        return self;
    }

    method success() returns Bool
    {
        200 <= self.getinfo('response-code') < 300
    }

    multi method getinfo(Str $info)
    {
        my ($code, $type) = %infofields{$info};

        given $type
        {
            when CURLINFO_STRING {
                $!handle.getinfo_str($code);
            }
            when CURLINFO_LONG {
                $!handle.getinfo_long($code);
            }
            when CURLINFO_DOUBLE {
                $!handle.getinfo_double($code);
            }
            when CURLINFO_SLIST {
                given $code {
                    when CURLINFO_CERTINFO {
                        $!handle.getinfo_certinfo;
                    }

                    when CURLINFO_COOKIELIST | CURLINFO_SSL_ENGINES {
                        $!handle.getinfo_slist($code);
                    }
                }
            }
            default {
                die "Unknown getinfo [$info]";
            }
        }
    }

    multi method getinfo(*@fields) returns Hash
    {
        my %info;
        for @fields {
            %info{$_} = self.getinfo($_);
        }
        return %info;
    }

    multi method getinfo() returns Hash
    {
        self.getinfo(%infofields.keys);
    }

    method FALLBACK($name, $param?)
    {
        return self.setopt(|($name => $param))
            if %opts{$name} and $param.defined;

        return $_ with %!receiveheaders{$name};

        return self.getinfo($name) if %infofields{$name};

        die "Unknown method $name";
    }

    method cleanup
    {
        $!header-slist.free if $!header-slist;
        $!header-slist = LibCurl::slist;
        fclose($!download-fh) if $!download-fh;
        fclose($!upload-fh) if $!upload-fh;
        $!download-fh = $!upload-fh = Pointer;
        $allhandles-lock.protect({ %allhandles{$!handle.id}:delete });
        .cleanup with $!handle;
        $!handle = LibCurl::EasyHandle;
        self.clear-form;
    }

    submethod DESTROY
    {
        self.cleanup;
    }
}
