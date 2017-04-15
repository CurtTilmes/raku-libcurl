use v6;

use NativeCall;
use LibCurl::EasyHandle;

my %allhandles;

my enum CURLOPT_TYPE <CURLOPT_BOOL CURLOPT_STR CURLOPT_LONG LIBCURL_HEADER
    LIBCURL_DOWNLOAD LIBCURL_UPLOAD LIBCURL_SEND LIBCURL_DEBUG LIBCURL_PRIVATE>;

my %opts =
    verbose              => (CURLOPT_VERBOSE,              CURLOPT_BOOL     ),
    noprogress           => (CURLOPT_NOPROGRESS,           CURLOPT_BOOL     ),
    header               => (CURLOPT_HEADER,               CURLOPT_BOOL     ),
    nosignal             => (CURLOPT_NOSIGNAL,             CURLOPT_BOOL     ),
    wildcardmatch        => (CURLOPT_WILDCARDMATCH,        CURLOPT_BOOL     ),
    followlocation       => (CURLOPT_FOLLOWLOCATION,       CURLOPT_BOOL     ),
    autoreferer          => (CURLOPT_AUTOREFERER,          CURLOPT_BOOL     ),
    referer              => (CURLOPT_REFERER,              CURLOPT_STR      ),
    httpget              => (CURLOPT_HTTPGET,              CURLOPT_BOOL     ),
    URL                  => (CURLOPT_URL,                  CURLOPT_STR      ),
    proxy                => (CURLOPT_PROXY,                CURLOPT_STR      ),
    proxyport            => (CURLOPT_PROXYPORT,            CURLOPT_LONG     ),
    proxytype            => (CURLOPT_PROXYTYPE,            CURLOPT_LONG     ),
    httpproxytunnel      => (CURLOPT_HTTPPROXYTUNNEL,      CURLOPT_BOOL     ),
    accept-encoding      => (CURLOPT_ACCEPT_ENCODING,      CURLOPT_STR      ),
    useragent            => (CURLOPT_USERAGENT,            CURLOPT_STR      ),
    failonerror          => (CURLOPT_FAILONERROR,          CURLOPT_BOOL     ),
    postfields           => (CURLOPT_POSTFIELDS,           CURLOPT_STR      ),
    postfieldsize        => (CURLOPT_POSTFIELDSIZE,        CURLOPT_LONG     ),
    userpwd              => (CURLOPT_USERPWD,              CURLOPT_STR      ),
    proxyuserpwd         => (CURLOPT_PROXYUSERPWD,         CURLOPT_STR      ),
    netrc                => (CURLOPT_NETRC,                CURLOPT_LONG     ),
    username             => (CURLOPT_USERNAME,             CURLOPT_STR      ),
    password             => (CURLOPT_PASSWORD,             CURLOPT_STR      ),
    httpauth             => (CURLOPT_HTTPAUTH,             CURLOPT_LONG     ),
    maxconnects          => (CURLOPT_MAXCONNECTS,          CURLOPT_LONG     ),
    fresh-connect        => (CURLOPT_FRESH_CONNECT,        CURLOPT_BOOL     ),
    forbid-reuse         => (CURLOPT_FORBID_REUSE,         CURLOPT_BOOL     ),
    customrequest        => (CURLOPT_CUSTOMREQUEST,        CURLOPT_STR      ),
    nobody               => (CURLOPT_NOBODY,               CURLOPT_BOOL     ),
    cookie               => (CURLOPT_COOKIE,               CURLOPT_STR      ),
    cookielist           => (CURLOPT_COOKIELIST,           CURLOPT_STR      ),
    cookiefile           => (CURLOPT_COOKIEFILE,           CURLOPT_STR      ),
    cookiejar            => (CURLOPT_COOKIEJAR,            CURLOPT_STR      ),
    ftp-use-epsv         => (CURLOPT_FTP_USE_EPSV,         CURLOPT_LONG     ),
    ftpport              => (CURLOPT_FTPPORT,              CURLOPT_STR      ),
    ftp-use-eprt         => (CURLOPT_FTP_USE_EPRT,         CURLOPT_BOOL     ),
    ftp-skip-pasv-ip     => (CURLOPT_FTP_SKIP_PASV_IP,     CURLOPT_BOOL     ),
    redir-protocols      => (CURLOPT_REDIR_PROTOCOLS,      CURLOPT_LONG     ),
    protocols            => (CURLOPT_PROTOCOLS,            CURLOPT_LONG     ),
    unrestricted-auth    => (CURLOPT_UNRESTRICTED_AUTH,    CURLOPT_BOOL     ),
    use-ssl              => (CURLOPT_USE_SSL,              CURLOPT_LONG     ),
    ssl-verifypeer       => (CURLOPT_SSL_VERIFYPEER,       CURLOPT_BOOL     ),
    ssl-verifyhost       => (CURLOPT_SSL_VERIFYHOST,       CURLOPT_LONG     ),
    CAinfo               => (CURLOPT_CAINFO,               CURLOPT_STR      ),
    CApath               => (CURLOPT_CAPATH,               CURLOPT_STR      ),
    timeout              => (CURLOPT_TIMEOUT,              CURLOPT_LONG     ),
    timeout-ms           => (CURLOPT_TIMEOUT_MS,           CURLOPT_LONG     ),
    low-speed-limit      => (CURLOPT_LOW_SPEED_LIMIT,      CURLOPT_LONG     ),
    low-speed-time       => (CURLOPT_LOW_SPEED_TIME,       CURLOPT_LONG     ),
    maxfilesize-large    => (CURLOPT_MAXFILESIZE_LARGE,    CURLOPT_LONG     ),
    maxredirs            => (CURLOPT_MAXREDIRS,            CURLOPT_LONG     ),
    Content-MD5          => (0,                            LIBCURL_HEADER   ),
    Content-Type         => (0,                            LIBCURL_HEADER   ),
    Host                 => (0,                            LIBCURL_HEADER   ),
    Accept               => (0,                            LIBCURL_HEADER   ),
    Expect               => (0,                            LIBCURL_HEADER   ),
    download             => (0,                            LIBCURL_DOWNLOAD ),
    upload               => (0,                            LIBCURL_UPLOAD   ),
    send                 => (0,                            LIBCURL_SEND     ),
    debug                => (0,                            LIBCURL_DEBUG    ),
    private              => (0,                            LIBCURL_PRIVATE  ),
;

my %infofields =
    effective-url        => (CURLINFO_EFFECTIVE_URL,    CURLINFO_STRING     ),
    response-code        => (CURLINFO_RESPONSE_CODE,    CURLINFO_LONG       ),
    total-time           => (CURLINFO_TOTAL_TIME,       CURLINFO_DOUBLE     ),
    namelookup-time      => (CURLINFO_NAMELOOKUP_TIME,  CURLINFO_DOUBLE     ),
    connect-time         => (CURLINFO_CONNECT_TIME,     CURLINFO_DOUBLE     ),
    pretransfer-time     => (CURLINFO_PRETRANSFER_TIME, CURLINFO_DOUBLE     ),
    size-upload          => (CURLINFO_SIZE_UPLOAD,      CURLINFO_DOUBLE     ),
    size-download        => (CURLINFO_SIZE_DOWNLOAD,    CURLINFO_DOUBLE     ),
    speed-download       => (CURLINFO_SPEED_DOWNLOAD,   CURLINFO_DOUBLE     ),
    speed-upload         => (CURLINFO_SPEED_UPLOAD,     CURLINFO_DOUBLE     ),
    header-size          => (CURLINFO_HEADER_SIZE,      CURLINFO_LONG       ),
    request-size         => (CURLINFO_REQUEST_SIZE,     CURLINFO_LONG       ),
    content-type         => (CURLINFO_CONTENT_TYPE,     CURLINFO_STRING     ),
    http-connectcode     => (CURLINFO_EFFECTIVE_URL,    CURLINFO_LONG       ),
    httpauth-avail       => (CURLINFO_HTTPAUTH_AVAIL,   CURLINFO_LONG       ),
    proxyauth-avail      => (CURLINFO_PROXYAUTH_AVAIL,  CURLINFO_LONG       ),
    os-errno             => (CURLINFO_OS_ERRNO,         CURLINFO_LONG       ),
    num-connects         => (CURLINFO_NUM_CONNECTS,     CURLINFO_LONG       ),
    ssl_engines          => (CURLINFO_SSL_ENGINES,      CURLINFO_SLIST      ),
    cookielist           => (CURLINFO_COOKIELIST,       CURLINFO_SLIST      ),
    lastsocket           => (CURLINFO_LASTSOCKET,       CURLINFO_LONG       ),
    ftp-entry-path       => (CURLINFO_FTP_ENTRY_PATH,   CURLINFO_STRING     ),
    redirect-url         => (CURLINFO_REDIRECT_URL,     CURLINFO_STRING     ),
    primary-ip           => (CURLINFO_PRIMARY_IP,       CURLINFO_STRING     ),
    appconnect_time      => (CURLINFO_APPCONNECT_TIME,  CURLINFO_DOUBLE     ),
    certinfo             => (CURLINFO_CERTINFO,         CURLINFO_SLIST      ),
    condition-unmet      => (CURLINFO_CONDITION_UNMET,  CURLINFO_LONG       ),
    rtsp-session-id      => (CURLINFO_RTSP_SESSION_ID,  CURLINFO_STRING     ),
    rtsp-client-cseq     => (CURLINFO_RTSP_CLIENT_CSEQ, CURLINFO_LONG       ),
    rtsp-server-cseq     => (CURLINFO_RTSP_SERVER_CSEQ, CURLINFO_LONG       ),
    rtsp-cseq-recv       => (CURLINFO_RTSP_CSEQ_RECV,   CURLINFO_LONG       ),
    primary-port         => (CURLINFO_PRIMARY_PORT,     CURLINFO_LONG       ),
    local-ip             => (CURLINFO_LOCAL_IP,         CURLINFO_STRING     ),
    local-port           => (CURLINFO_LOCAL_PORT,       CURLINFO_LONG       ),
    tls-session          => (CURLINFO_TLS_SESSION,      CURLINFO_SLIST      ),
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
    my $bytes = nativecast(CArray[int8], $ptr);

    my $easy = easy-lookup($handleptr);

    my $header = Buf.new($bytes[0 ..^ $size * $nitems]).decode;

    if $header ~~ /^HTTP\/1.1 /
    {
        $easy.statusline = $header.trim;
    }
    elsif $header ~~ /^(<-[:]>+) ': ' (.*)$/
    {
        $easy.receiveheaders{$0} = $1.trim;
    }

    return $size * $nitems;
}

sub memcpy(Pointer $dest, CArray[int8], uint32 $n) is native { * }

sub readfunction(Pointer $ptr, uint32 $size, uint32 $nmemb,
                        Pointer $handleptr) returns uint32
{
    my $easy = easy-lookup($handleptr);

    return 0 if $easy.sendindex >= $easy.sendbuf.elems;

    my $tosend = min $easy.sendbuf.elems - $easy.sendindex, $size * $nmemb;

    my $subbuf = CArray[int8].new($easy.sendbuf.subbuf($easy.sendindex,
                                                       $tosend));

    memcpy($ptr, $subbuf, $tosend);

    $easy.sendindex += $tosend;

    return $tosend;
}

sub writefunction(Pointer $ptr, uint32 $size, uint32 $nmemb,
                      Pointer $handleptr) returns uint32
{
    my $easy = easy-lookup($handleptr);
    my $bytes = nativecast(CArray[int8], $ptr);
    $easy.buf ~= Buf.new($bytes[0 ..^ $size * $nmemb]);
    return $size * $nmemb;
}

sub debugfunction(Pointer $handleptr, uint32 $type, Pointer $data, size_t $size,
    Pointer $userptr)
{
    my $easy = easy-lookup($handleptr);

    my $bytes = nativecast(CArray[int8], $data);
    my $buf = Buf.new($bytes[0 ..^ $size]);
    say $type, $buf.decode;

    return 0;
}

sub xferinfofunction(Pointer $handleptr, long $dltotal, long $dlnow,
		     long $ultotal, long $ulnow)
{
    my $easy = easy-lookup($handleptr);
    say "$dltotal $dlnow $ultotal $ulnow";

    return 0;
}

class LibCurl::Easy
{
    has LibCurl::EasyHandle $.handle;
    has %.receiveheaders is rw;
    has $.statusline is rw;
    has %.sendheaders;
    has Pointer $.header-slist;
    has Pointer $.upload-fh;
    has Pointer $.download-fh;
    has Buf $.sendbuf;
    has Int $.sendindex is rw;
    has Buf $.buf is rw;
    has $.errorbuffer;
    has &.debugfunction;
    has &.xferinfofunction;
    has $.private;

    sub fopen(Str $path, Str $mode) returns Pointer is native { * }

    sub fclose(Pointer $fp) returns int32 is native { * }

    sub curl_slist_append(Pointer, Str) is native(LIBCURL) returns Pointer { * }

    sub curl_slist_free_all(Pointer) is native(LIBCURL) { * }

    method version { curl_version }

    method new(|opts)
    {
        my $handle = LibCurl::EasyHandle.new;
        my $errorbuffer = CArray[int8].new;
        $errorbuffer[0] = 0;
        $errorbuffer[CURL_ERROR_SIZE] = 0;
        my $self = self.bless(:$handle, :$errorbuffer);
        %allhandles{$handle.id} = $self;
        $handle.setopt(CURLOPT_HEADERDATA, $handle);
        $handle.setopt(CURLOPT_HEADERFUNCTION, &headerfunction);
        $handle.setopt(CURLOPT_ERRORBUFFER, $errorbuffer);
        $self.setopt(|opts);
        return $self;
    }

    method content($encoding = 'utf-8') { $!buf.decode($encoding) }

    method error() { nativecast(Str, $!errorbuffer) }

    method get-header($field) { %!receiveheaders{$field} }

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

                when CURLOPT_LONG|CURLOPT_STR {
                    $!handle.setopt($code, $param);
                }

                when LIBCURL_HEADER {
                    self.set-header($option, $param);
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
                        when Str { $!sendbuf = Buf.new($param.encode) }
                        default  { die "Don't know how to send $param" }
                    }
                    $!sendindex = 0;
                    $!handle.setopt(CURLOPT_UPLOAD, 1);
                    $!handle.setopt(CURLOPT_INFILESIZE_LARGE, $!sendbuf.elems);
                    $!handle.setopt(CURLOPT_READDATA, $!handle);
                    $!handle.setopt(CURLOPT_READFUNCTION, &readfunction);
                }

		when LIBCURL_DEBUG {
		    $!handle.setopt(CURLOPT_DEBUGFUNCTION, &debugfunction);
		    $!handle.setopt(CURLOPT_VERBOSE, 1);
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

    method set-header($field, $value)
    {
        %!sendheaders{$field} = $value;
        curl_slist_free_all($!header-slist) if defined $!header-slist;
        $!header-slist = Pointer;
        return self;
    }

    method prepare()
    {
        if %!sendheaders.elems and !$!header-slist
        {
            for %!sendheaders.kv -> $header, $value {
                $!header-slist = curl_slist_append($!header-slist, 
                                                   "$header: $value");
            }
            $!handle.setopt(CURLOPT_HTTPHEADER, $!header-slist);
        }

        unless $!download-fh 
        {
            $!buf = Buf.new;
            $!handle.setopt(CURLOPT_WRITEDATA, $!handle);
            $!handle.setopt(CURLOPT_WRITEFUNCTION, &writefunction);
        }

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

    method perform()
    {
        self.prepare;

        my $ret = $!handle.perform;

        self.finish;

        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;

        return self;
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
                return []; # TODO
            }
            default {
                die "Unknown getinfo [$info]";
            }
        }
    }

    multi method getinfo(*@fields)
    {
        my %info;
        for @fields {
            %info{$_} = self.getinfo($_);
        }
        return %info;
    }

    multi method getinfo()
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

    submethod DESTROY
    {
        curl_slist_free_all($!header-slist) if $!header-slist;
        fclose($!download-fh) if $!download-fh;
        fclose($!upload-fh) if $!upload-fh;
        %allhandles{$!handle.id}:delete;
        $!handle.cleanup;
    }
}
