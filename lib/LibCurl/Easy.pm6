use v6;

use NativeCall;

constant LIBCURL = "curl";

constant CURLOPT_URL is export                          = 10002;
constant CURLE_OK    is export                          = 0;

constant CURL_ERROR_SIZE is export                      = 256;

constant CURL_NETRC_IGNORED                   is export = 0;
constant CURL_NETRC_OPTIONAL                  is export = 1;
constant CURL_NETRC_REQUIRED                  is export = 2;

constant CURLPROXY_HTTP                       is export = 0;
constant CURLPROXY_HTTP_1_0                   is export = 1;
constant CURLPROXY_SOCKS4                     is export = 4;
constant CURLPROXY_SOCKS5                     is export = 5;
constant CURLPROXY_SOCKS4A                    is export = 6;
constant CURLPROXY_SOCKS5_HOSTNAME            is export = 7;

constant CURLUSESSL_NONE                      is export = 0;
constant CURLUSESSL_TRY                       is export = 1;
constant CURLUSESSL_CONTROL                   is export = 2;
constant CURLUSESSL_ALL                       is export = 3;

constant CURLINFO_STRING                                = 0x100000;
constant CURLINFO_LONG                                  = 0x200000;
constant CURLINFO_DOUBLE                                = 0x300000;
constant CURLINFO_SLIST                                 = 0x400000;

constant CURLINFO_EFFECTIVE_URL               is export = CURLINFO_STRING + 1;
constant CURLINFO_RESPONSE_CODE               is export = CURLINFO_LONG   + 2;
constant CURLINFO_TOTAL_TIME                  is export = CURLINFO_DOUBLE + 3;
constant CURLINFO_NAMELOOKUP_TIME             is export = CURLINFO_DOUBLE + 4;
constant CURLINFO_CONNECT_TIME                is export = CURLINFO_DOUBLE + 5;
constant CURLINFO_PRETRANSFER_TIME            is export = CURLINFO_DOUBLE + 6;
constant CURLINFO_SIZE_UPLOAD                 is export = CURLINFO_DOUBLE + 7;
constant CURLINFO_SIZE_DOWNLOAD               is export = CURLINFO_DOUBLE + 8;
constant CURLINFO_SPEED_DOWNLOAD              is export = CURLINFO_DOUBLE + 9;
constant CURLINFO_SPEED_UPLOAD                is export = CURLINFO_DOUBLE + 10;
constant CURLINFO_HEADER_SIZE                 is export = CURLINFO_LONG   + 11;
constant CURLINFO_REQUEST_SIZE                is export = CURLINFO_LONG   + 12;
constant CURLINFO_SSL_VERIFYRESULT            is export = CURLINFO_LONG   + 13;
constant CURLINFO_FILETIME                    is export = CURLINFO_LONG   + 14;
constant CURLINFO_CONTENT_LENGTH_DOWNLOAD     is export = CURLINFO_DOUBLE + 15;
constant CURLINFO_CONTENT_LENGTH_UPLOAD       is export = CURLINFO_DOUBLE + 16;
constant CURLINFO_STARTTRANSFER_TIME          is export = CURLINFO_DOUBLE + 17;
constant CURLINFO_CONTENT_TYPE                is export = CURLINFO_STRING + 18;
constant CURLINFO_REDIRECT_TIME               is export = CURLINFO_DOUBLE + 19;
constant CURLINFO_REDIRECT_COUNT              is export = CURLINFO_LONG   + 20;
constant CURLINFO_PRIVATE                     is export = CURLINFO_STRING + 21;
constant CURLINFO_HTTP_CONNECTCODE            is export = CURLINFO_LONG   + 22;
constant CURLINFO_HTTPAUTH_AVAIL              is export = CURLINFO_LONG   + 23;
constant CURLINFO_PROXYAUTH_AVAIL             is export = CURLINFO_LONG   + 24;
constant CURLINFO_OS_ERRNO                    is export = CURLINFO_LONG   + 25;
constant CURLINFO_NUM_CONNECTS                is export = CURLINFO_LONG   + 26;
constant CURLINFO_SSL_ENGINES                 is export = CURLINFO_SLIST  + 27;
constant CURLINFO_COOKIELIST                  is export = CURLINFO_SLIST  + 28;
constant CURLINFO_LASTSOCKET                  is export = CURLINFO_LONG   + 29;
constant CURLINFO_FTP_ENTRY_PATH              is export = CURLINFO_STRING + 30;
constant CURLINFO_REDIRECT_URL                is export = CURLINFO_STRING + 31;
constant CURLINFO_PRIMARY_IP                  is export = CURLINFO_STRING + 32;
constant CURLINFO_APPCONNECT_TIME             is export = CURLINFO_DOUBLE + 33;
constant CURLINFO_CERTINFO                    is export = CURLINFO_SLIST  + 34;
constant CURLINFO_CONDITION_UNMET             is export = CURLINFO_LONG   + 35;
constant CURLINFO_RTSP_SESSION_ID             is export = CURLINFO_STRING + 36;
constant CURLINFO_RTSP_CLIENT_CSEQ            is export = CURLINFO_LONG   + 37;
constant CURLINFO_RTSP_SERVER_CSEQ            is export = CURLINFO_LONG   + 38;
constant CURLINFO_RTSP_CSEQ_RECV              is export = CURLINFO_LONG   + 39;
constant CURLINFO_PRIMARY_PORT                is export = CURLINFO_LONG   + 40;
constant CURLINFO_LOCAL_IP                    is export = CURLINFO_STRING + 41;
constant CURLINFO_LOCAL_PORT                  is export = CURLINFO_LONG   + 42;
constant CURLINFO_TLS_SESSION                 is export = CURLINFO_SLIST  + 43;

constant CURL_GLOBAL_DEFAULT                  is export = 0x3;
constant CURLOPT_FILE                         is export = 10001;
constant CURLOPT_WRITEDATA                    is export = 10001;
constant CURLOPT_PORT                         is export = 3;
constant CURLOPT_PROXY                        is export = 10004;
constant CURLOPT_USERPWD                      is export = 10005;
constant CURLOPT_PROXYUSERPWD                 is export = 10006;
constant CURLOPT_RANGE                        is export = 10007;
constant CURLOPT_INFILE                       is export = 10009;
constant CURLOPT_READDATA                     is export = 10009;
constant CURLOPT_ERRORBUFFER                  is export = 10010;
constant CURLOPT_WRITEFUNCTION                is export = 20011;
constant CURLOPT_READFUNCTION                 is export = 20012;
constant CURLOPT_TIMEOUT                      is export = 13;
constant CURLOPT_INFILESIZE                   is export = 14;
constant CURLOPT_POSTFIELDS                   is export = 10015;
constant CURLOPT_REFERER                      is export = 10016;
constant CURLOPT_FTPPORT                      is export = 10017;
constant CURLOPT_USERAGENT                    is export = 10018;
constant CURLOPT_LOW_SPEED_LIMIT              is export = 19;
constant CURLOPT_LOW_SPEED_TIME               is export = 20;
constant CURLOPT_RESUME_FROM                  is export = 21;
constant CURLOPT_COOKIE                       is export = 10022;
constant CURLOPT_HTTPHEADER                   is export = 10023;
constant CURLOPT_HTTPPOST                     is export = 10024;
constant CURLOPT_SSLCERT                      is export = 10025;
constant CURLOPT_KEYPASSWD                    is export = 10026;
constant CURLOPT_CRLF                         is export = 27;
constant CURLOPT_QUOTE                        is export = 10028;
constant CURLOPT_WRITEHEADER                  is export = 10029;
constant CURLOPT_COOKIEFILE                   is export = 10031;
constant CURLOPT_SSLVERSION                   is export = 32;
constant CURLOPT_TIMECONDITION                is export = 33;
constant CURLOPT_TIMEVALUE                    is export = 34;
constant CURLOPT_CUSTOMREQUEST                is export = 10036;
constant CURLOPT_STDERR                       is export = 10037;
constant CURLOPT_POSTQUOTE                    is export = 10039;
constant CURLOPT_WRITEINFO                    is export = 10040;
constant CURLOPT_VERBOSE                      is export = 41;
constant CURLOPT_HEADER                       is export = 42;
constant CURLOPT_NOPROGRESS                   is export = 43;
constant CURLOPT_NOBODY                       is export = 44;
constant CURLOPT_FAILONERROR                  is export = 45;
constant CURLOPT_UPLOAD                       is export = 46;
constant CURLOPT_POST                         is export = 47;
constant CURLOPT_DIRLISTONLY                  is export = 48;
constant CURLOPT_APPEND                       is export = 50;
constant CURLOPT_NETRC                        is export = 51;
constant CURLOPT_FOLLOWLOCATION               is export = 52;
constant CURLOPT_TRANSFERTEXT                 is export = 53;
constant CURLOPT_PUT                          is export = 54;
constant CURLOPT_PROGRESSFUNCTION             is export = 20056;
constant CURLOPT_PROGRESSDATA                 is export = 10057;
constant CURLOPT_AUTOREFERER                  is export = 58;
constant CURLOPT_PROXYPORT                    is export = 59;
constant CURLOPT_POSTFIELDSIZE                is export = 60;
constant CURLOPT_HTTPPROXYTUNNEL              is export = 61;
constant CURLOPT_INTERFACE                    is export = 10062;
constant CURLOPT_KRBLEVEL                     is export = 10063;
constant CURLOPT_SSL_VERIFYPEER               is export = 64;
constant CURLOPT_SSL_VERIFYHOST               is export = 81;
constant CURLOPT_CAINFO                       is export = 10065;
constant CURLOPT_MAXREDIRS                    is export = 68;
constant CURLOPT_FILETIME                     is export = 69;
constant CURLOPT_TELNETOPTIONS                is export = 10070;
constant CURLOPT_MAXCONNECTS                  is export = 71;
constant CURLOPT_CLOSEPOLICY                  is export = 72;
constant CURLOPT_FRESH_CONNECT                is export = 74;
constant CURLOPT_FORBID_REUSE                 is export = 75;
constant CURLOPT_RANDOM_FILE                  is export = 10076;
constant CURLOPT_EGDSOCKET                    is export = 10077;
constant CURLOPT_CONNECTTIMEOUT               is export = 78;
constant CURLOPT_HEADERFUNCTION               is export = 20079;
constant CURLOPT_HTTPGET                      is export = 80;
constant CURLOPT_COOKIEJAR                    is export = 10082;
constant CURLOPT_SSL_CIPHER_LIST              is export = 10083;
constant CURLOPT_HTTP_VERSION                 is export = 84;
constant CURLOPT_FTP_USE_EPSV                 is export = 85;
constant CURLOPT_SSLCERTTYPE                  is export = 10086;
constant CURLOPT_SSLKEY                       is export = 10087;
constant CURLOPT_SSLKEYTYPE                   is export = 10088;
constant CURLOPT_SSLENGINE                    is export = 10089;
constant CURLOPT_SSLENGINE_DEFAULT            is export = 90;
constant CURLOPT_DNS_USE_GLOBAL_CACHE         is export = 91;
constant CURLOPT_DNS_CACHE_TIMEOUT            is export = 92;
constant CURLOPT_PREQUOTE                     is export = 10093;
constant CURLOPT_DEBUGFUNCTION                is export = 20094;
constant CURLOPT_DEBUGDATA                    is export = 10095;
constant CURLOPT_COOKIESESSION                is export = 96;
constant CURLOPT_CAPATH                       is export = 10097;
constant CURLOPT_BUFFERSIZE                   is export = 98;
constant CURLOPT_NOSIGNAL                     is export = 99;
constant CURLOPT_SHARE                        is export = 10100;
constant CURLOPT_PROXYTYPE                    is export = 101;
constant CURLOPT_ACCEPT_ENCODING              is export = 10102;
constant CURLOPT_PRIVATE                      is export = 10103;
constant CURLOPT_HTTP200ALIASES               is export = 10104;
constant CURLOPT_UNRESTRICTED_AUTH            is export = 105;
constant CURLOPT_FTP_USE_EPRT                 is export = 106;
constant CURLOPT_HTTPAUTH                     is export = 107;
constant CURLOPT_SSL_CTX_FUNCTION             is export = 20108;
constant CURLOPT_SSL_CTX_DATA                 is export = 10109;
constant CURLOPT_PROXYAUTH                    is export = 111;
constant CURLOPT_FTP_RESPONSE_TIMEOUT         is export = 112;
constant CURLOPT_IPRESOLVE                    is export = 113;
constant CURLOPT_MAXFILESIZE                  is export = 114;
constant CURLOPT_INFILESIZE_LARGE             is export = 30115;
constant CURLOPT_RESUME_FROM_LARGE            is export = 30116;
constant CURLOPT_MAXFILESIZE_LARGE            is export = 30117;
constant CURLOPT_NETRC_FILE                   is export = 10118;
constant CURLOPT_USE_SSL                      is export = 119;
constant CURLOPT_POSTFIELDSIZE_LARGE          is export = 30120;
constant CURLOPT_TCP_NODELAY                  is export = 121;
constant CURLOPT_FTPSSLAUTH                   is export = 129;
constant CURLOPT_IOCTLFUNCTION                is export = 20130;
constant CURLOPT_IOCTLDATA                    is export = 10131;
constant CURLOPT_FTP_ACCOUNT                  is export = 10134;
constant CURLOPT_COOKIELIST                   is export = 10135;
constant CURLOPT_IGNORE_CONTENT_LENGTH        is export = 136;
constant CURLOPT_FTP_SKIP_PASV_IP             is export = 137;
constant CURLOPT_FTP_FILEMETHOD               is export = 138;
constant CURLOPT_LOCALPORT                    is export = 139;
constant CURLOPT_LOCALPORTRANGE               is export = 140;
constant CURLOPT_CONNECT_ONLY                 is export = 141;
constant CURLOPT_FTP_CREATE_MISSING_DIRS      is export = 110;
constant CURLOPT_CONV_FROM_NETWORK_FUNCTION   is export = 20142;
constant CURLOPT_CONV_TO_NETWORK_FUNCTION     is export = 20143;
constant CURLOPT_CONV_FROM_UTF8_FUNCTION      is export = 20144;
constant CURLOPT_MAX_SEND_SPEED_LARGE         is export = 30145;
constant CURLOPT_MAX_RECV_SPEED_LARGE         is export = 30146;
constant CURLOPT_FTP_ALTERNATIVE_TO_USER      is export = 10147;
constant CURLOPT_SSH_HOST_PUBLIC_KEY_MD5      is export = 10162;
constant CURLOPT_HTTP_TRANSFER_DECODING       is export = 157;
constant CURLOPT_SOCKOPTFUNCTION              is export = 20148;
constant CURLOPT_SOCKOPTDATA                  is export = 10149;
constant CURLOPT_SSL_SESSIONID_CACHE          is export = 150;
constant CURLOPT_SSH_AUTH_TYPES               is export = 151;
constant CURLOPT_SSH_PUBLIC_KEYFILE           is export = 10152;
constant CURLOPT_SSH_PRIVATE_KEYFILE          is export = 10153;
constant CURLOPT_FTP_SSL_CCC                  is export = 154;
constant CURLOPT_TIMEOUT_MS                   is export = 155;
constant CURLOPT_CONNECTTIMEOUT_MS            is export = 156;
constant CURLOPT_HTTP_CONTENT_DECODING        is export = 158;
constant CURLOPT_NEW_FILE_PERMS               is export = 159;
constant CURLOPT_NEW_DIRECTORY_PERMS          is export = 160;
constant CURLOPT_POSTREDIR                    is export = 161;
constant CURLOPT_OPENSOCKETFUNCTION           is export = 20163;
constant CURLOPT_OPENSOCKETDATA               is export = 10164;
constant CURLOPT_COPYPOSTFIELDS               is export = 10165;
constant CURLOPT_PROXY_TRANSFER_MODE          is export = 166;
constant CURLOPT_SEEKFUNCTION                 is export = 20167;
constant CURLOPT_SEEKDATA                     is export = 10168;
constant CURLOPT_CRLFILE                      is export = 10169;
constant CURLOPT_ISSUERCERT                   is export = 10170;
constant CURLOPT_ADDRESS_SCOPE                is export = 171;
constant CURLOPT_CERTINFO                     is export = 172;
constant CURLOPT_USERNAME                     is export = 10173;
constant CURLOPT_PASSWORD                     is export = 10174;
constant CURLOPT_PROXYUSERNAME                is export = 10175;
constant CURLOPT_PROXYPASSWORD                is export = 10176;
constant CURLOPT_NOPROXY                      is export = 10177;
constant CURLOPT_TFTP_BLKSIZE                 is export = 178;
constant CURLOPT_SOCKS5_GSSAPI_SERVICE        is export = 10179;
constant CURLOPT_SOCKS5_GSSAPI_NEC            is export = 180;
constant CURLOPT_PROTOCOLS                    is export = 181;
constant CURLOPT_REDIR_PROTOCOLS              is export = 182;
constant CURLOPT_SSH_KNOWNHOSTS               is export = 10183;
constant CURLOPT_SSH_KEYFUNCTION              is export = 20184;
constant CURLOPT_SSH_KEYDATA                  is export = 10185;
constant CURLOPT_MAIL_FROM                    is export = 10186;
constant CURLOPT_MAIL_RCPT                    is export = 10187;
constant CURLOPT_FTP_USE_PRET                 is export = 188;
constant CURLOPT_RTSP_REQUEST                 is export = 189;
constant CURLOPT_RTSP_SESSION_ID              is export = 10190;
constant CURLOPT_RTSP_STREAM_URI              is export = 10191;
constant CURLOPT_RTSP_TRANSPORT               is export = 10192;
constant CURLOPT_RTSP_CLIENT_CSEQ             is export = 193;
constant CURLOPT_RTSP_SERVER_CSEQ             is export = 194;
constant CURLOPT_INTERLEAVEDATA               is export = 10195;
constant CURLOPT_INTERLEAVEFUNCTION           is export = 20196;
constant CURLOPT_WILDCARDMATCH                is export = 197;
constant CURLOPT_CHUNK_BGN_FUNCTION           is export = 20198;
constant CURLOPT_CHUNK_END_FUNCTION           is export = 20199;
constant CURLOPT_FNMATCH_FUNCTION             is export = 20200;
constant CURLOPT_CHUNK_DATA                   is export = 10201;
constant CURLOPT_FNMATCH_DATA                 is export = 10202;
constant CURLOPT_RESOLVE                      is export = 10203;
constant CURLOPT_TLSAUTH_USERNAME             is export = 10204;
constant CURLOPT_TLSAUTH_PASSWORD             is export = 10205;
constant CURLOPT_TLSAUTH_TYPE                 is export = 10206;
constant CURLOPT_TRANSFER_ENCODING            is export = 207;
constant CURLOPT_CLOSESOCKETFUNCTION          is export = 20208;
constant CURLOPT_CLOSESOCKETDATA              is export = 10209;
constant CURLOPT_GSSAPI_DELEGATION            is export = 210;
constant CURLOPT_DNS_SERVERS                  is export = 10211;
constant CURLOPT_ACCEPTTIMEOUT_MS             is export = 212;
constant CURLOPT_TCP_KEEPALIVE                is export = 213;
constant CURLOPT_TCP_KEEPIDLE                 is export = 214;
constant CURLOPT_TCP_KEEPINTVL                is export = 215;
constant CURLOPT_SSL_OPTIONS                  is export = 216;
constant CURLOPT_MAIL_AUTH                    is export = 10217;

my enum CURLOPT_TYPE <CURLOPT_BOOL CURLOPT_STR CURLOPT_LONG
    LIBCURL_HEADER LIBCURL_DOWNLOAD LIBCURL_UPLOAD LIBCURL_SEND>;

my %opts =
    verbose           => (CURLOPT_VERBOSE,           CURLOPT_BOOL     ),
    header            => (CURLOPT_HEADER,            CURLOPT_BOOL     ),
    nosignal          => (CURLOPT_NOSIGNAL,          CURLOPT_BOOL     ),
    wildcardmatch     => (CURLOPT_WILDCARDMATCH,     CURLOPT_BOOL     ),
    followlocation    => (CURLOPT_FOLLOWLOCATION,    CURLOPT_BOOL     ),
    autoreferer       => (CURLOPT_AUTOREFERER,       CURLOPT_BOOL     ),
    referer           => (CURLOPT_REFERER,           CURLOPT_STR      ),
    httpget           => (CURLOPT_HTTPGET,           CURLOPT_BOOL     ),
    URL               => (CURLOPT_URL,               CURLOPT_STR      ),
    proxy             => (CURLOPT_PROXY,             CURLOPT_STR      ),
    proxyport         => (CURLOPT_PROXYPORT,         CURLOPT_LONG     ),
    proxytype         => (CURLOPT_PROXYTYPE,         CURLOPT_LONG     ),
    httpproxytunnel   => (CURLOPT_HTTPPROXYTUNNEL,   CURLOPT_BOOL     ),
    accept-encoding   => (CURLOPT_ACCEPT_ENCODING,   CURLOPT_STR      ),
    useragent         => (CURLOPT_USERAGENT,         CURLOPT_STR      ),
    failonerror       => (CURLOPT_FAILONERROR,       CURLOPT_BOOL     ),
    postfields        => (CURLOPT_POSTFIELDS,        CURLOPT_STR      ),
    postfieldsize     => (CURLOPT_POSTFIELDSIZE,     CURLOPT_LONG     ),
    userpwd           => (CURLOPT_USERPWD,           CURLOPT_STR      ),
    proxyuserpwd      => (CURLOPT_PROXYUSERPWD,      CURLOPT_STR      ),
    netrc             => (CURLOPT_NETRC,             CURLOPT_LONG     ),
    username          => (CURLOPT_USERNAME,          CURLOPT_STR      ),
    password          => (CURLOPT_PASSWORD,          CURLOPT_STR      ),
    httpauth          => (CURLOPT_HTTPAUTH,          CURLOPT_LONG     ),
    maxconnects       => (CURLOPT_MAXCONNECTS,       CURLOPT_LONG     ),
    fresh-connect     => (CURLOPT_FRESH_CONNECT,     CURLOPT_BOOL     ),
    forbid-reuse      => (CURLOPT_FORBID_REUSE,      CURLOPT_BOOL     ),
    customrequest     => (CURLOPT_CUSTOMREQUEST,     CURLOPT_STR      ),
    nobody            => (CURLOPT_NOBODY,            CURLOPT_BOOL     ),
    cookie            => (CURLOPT_COOKIE,            CURLOPT_STR      ),
    cookielist        => (CURLOPT_COOKIELIST,        CURLOPT_STR      ),
    cookiefile        => (CURLOPT_COOKIEFILE,        CURLOPT_STR      ),
    cookiejar         => (CURLOPT_COOKIEJAR,         CURLOPT_STR      ),
    ftp-use-epsv      => (CURLOPT_FTP_USE_EPSV,      CURLOPT_LONG     ),
    ftpport           => (CURLOPT_FTPPORT,           CURLOPT_STR      ),
    ftp-use-eprt      => (CURLOPT_FTP_USE_EPRT,      CURLOPT_BOOL     ),
    ftp-skip-pasv-ip  => (CURLOPT_FTP_SKIP_PASV_IP,  CURLOPT_BOOL     ),
    redir-protocols   => (CURLOPT_REDIR_PROTOCOLS,   CURLOPT_LONG     ),
    protocols         => (CURLOPT_PROTOCOLS,         CURLOPT_LONG     ),
    unrestricted-auth => (CURLOPT_UNRESTRICTED_AUTH, CURLOPT_BOOL     ),
    use-ssl           => (CURLOPT_USE_SSL,           CURLOPT_LONG     ),
    ssl-verifypeer    => (CURLOPT_SSL_VERIFYPEER,    CURLOPT_BOOL     ),
    ssl-verifyhost    => (CURLOPT_SSL_VERIFYHOST,    CURLOPT_LONG     ),
    CAinfo            => (CURLOPT_CAINFO,            CURLOPT_STR      ),
    CApath            => (CURLOPT_CAPATH,            CURLOPT_STR      ),
    timeout           => (CURLOPT_TIMEOUT,           CURLOPT_LONG     ),
    timeout-ms        => (CURLOPT_TIMEOUT_MS,        CURLOPT_LONG     ),
    low-speed-limit   => (CURLOPT_LOW_SPEED_LIMIT,   CURLOPT_LONG     ),
    low-speed-time    => (CURLOPT_LOW_SPEED_TIME,    CURLOPT_LONG     ),
    maxfilesize-large => (CURLOPT_MAXFILESIZE_LARGE, CURLOPT_LONG     ),
    maxredirs         => (CURLOPT_MAXREDIRS,         CURLOPT_LONG     ),
    Content-MD5       => (0,                         LIBCURL_HEADER   ),
    Content-Type      => (0,                         LIBCURL_HEADER   ),
    Host              => (0,                         LIBCURL_HEADER   ),
    Accept            => (0,                         LIBCURL_HEADER   ),
    Expect            => (0,                         LIBCURL_HEADER   ),
    download          => (0,                         LIBCURL_DOWNLOAD ),
    upload            => (0,                         LIBCURL_UPLOAD   ),
    send              => (0,                         LIBCURL_SEND     ),
;

my %infofields =
    effective-url    => (CURLINFO_EFFECTIVE_URL,    CURLINFO_STRING  ),
    response-code    => (CURLINFO_RESPONSE_CODE,    CURLINFO_LONG    ),
    total-time       => (CURLINFO_TOTAL_TIME,       CURLINFO_DOUBLE  ),
    namelookup-time  => (CURLINFO_NAMELOOKUP_TIME,  CURLINFO_DOUBLE  ),
    connect-time     => (CURLINFO_CONNECT_TIME,     CURLINFO_DOUBLE  ),
    pretransfer-time => (CURLINFO_PRETRANSFER_TIME, CURLINFO_DOUBLE  ),
    size-upload      => (CURLINFO_SIZE_UPLOAD,      CURLINFO_DOUBLE  ),
    size-download    => (CURLINFO_SIZE_DOWNLOAD,    CURLINFO_DOUBLE  ),
    speed-download   => (CURLINFO_SPEED_DOWNLOAD,   CURLINFO_DOUBLE  ),
    speed-upload     => (CURLINFO_SPEED_UPLOAD,     CURLINFO_DOUBLE  ),
    header-size      => (CURLINFO_HEADER_SIZE,      CURLINFO_LONG    ),
    request-size     => (CURLINFO_REQUEST_SIZE,     CURLINFO_LONG    ),
    content-type     => (CURLINFO_CONTENT_TYPE,     CURLINFO_STRING  ),
    http-connectcode => (CURLINFO_EFFECTIVE_URL,    CURLINFO_LONG    ),
    httpauth-avail   => (CURLINFO_HTTPAUTH_AVAIL,   CURLINFO_LONG    ),
    proxyauth-avail  => (CURLINFO_PROXYAUTH_AVAIL,  CURLINFO_LONG    ),
    os-errno         => (CURLINFO_OS_ERRNO,         CURLINFO_LONG    ),
    num-connects     => (CURLINFO_NUM_CONNECTS,     CURLINFO_LONG    ),
    ssl_engines      => (CURLINFO_SSL_ENGINES,      CURLINFO_SLIST   ),
    cookielist       => (CURLINFO_COOKIELIST,       CURLINFO_SLIST   ),
    lastsocket       => (CURLINFO_LASTSOCKET,       CURLINFO_LONG    ),
    ftp-entry-path   => (CURLINFO_FTP_ENTRY_PATH,   CURLINFO_STRING  ),
    redirect-url     => (CURLINFO_REDIRECT_URL,     CURLINFO_STRING  ),
    primary-ip       => (CURLINFO_PRIMARY_IP,       CURLINFO_STRING  ),
    appconnect_time  => (CURLINFO_APPCONNECT_TIME,  CURLINFO_DOUBLE  ),
    certinfo         => (CURLINFO_CERTINFO,         CURLINFO_SLIST   ),
    condition-unmet  => (CURLINFO_CONDITION_UNMET,  CURLINFO_LONG    ),
    rtsp-session-id  => (CURLINFO_RTSP_SESSION_ID,  CURLINFO_STRING  ),
    rtsp-client-cseq => (CURLINFO_RTSP_CLIENT_CSEQ, CURLINFO_LONG    ),
    rtsp-server-cseq => (CURLINFO_RTSP_SERVER_CSEQ, CURLINFO_LONG    ),
    rtsp-cseq-recv   => (CURLINFO_RTSP_CSEQ_RECV,   CURLINFO_LONG    ),
    primary-port     => (CURLINFO_PRIMARY_PORT,     CURLINFO_LONG    ),
    local-ip         => (CURLINFO_LOCAL_IP,         CURLINFO_STRING  ),
    local-port       => (CURLINFO_LOCAL_PORT,       CURLINFO_LONG    ),
    tls-session      => (CURLINFO_TLS_SESSION,      CURLINFO_SLIST   ),
;

sub curl_global_init(int32) returns uint32 is native(LIBCURL) { * }

sub curl_global_cleanup() is native(LIBCURL) { * }

INIT { curl_global_init(CURL_GLOBAL_DEFAULT) }

END { curl_global_cleanup() }

class X::LibCurl is Exception
{
    has Int $.code;

    sub curl_easy_strerror(uint32) returns Str is native(LIBCURL) { * }

    method Int() { $!code }

    method message() { curl_easy_strerror($!code) }
}

class LibCurl::EasyHandle is repr('CPointer')
{
    sub curl_version() returns Str is native(LIBCURL) { * }

    sub curl_easy_init() returns LibCurl::EasyHandle is native(LIBCURL) { * }

    sub curl_easy_cleanup(LibCurl::EasyHandle) is native(LIBCURL) { * }

    sub curl_easy_reset(LibCurl::EasyHandle) is native(LIBCURL) { * }

    sub curl_easy_duphandle(LibCurl::EasyHandle) returns LibCurl::EasyHandle
        is native(LIBCURL) { * }

    sub curl_easy_setopt_str(LibCurl::EasyHandle, uint32, Str) returns uint32
        is native(LIBCURL) is symbol('curl_easy_setopt') { * }

    sub curl_easy_setopt_long(LibCurl::EasyHandle, uint32, long) returns uint32
        is native(LIBCURL) is symbol('curl_easy_setopt') { * }

    sub curl_easy_setopt_ptr(LibCurl::EasyHandle, uint32, Pointer)
        returns uint32 is native(LIBCURL) is symbol('curl_easy_setopt') { * }

    sub curl_easy_setopt_cb(LibCurl::EasyHandle, uint32,
        &cb (Pointer $ptr, uint32 $size, uint32 $nmemb,
             OpaquePointer $stream --> uint32))
        returns uint32 is native(LIBCURL) is symbol('curl_easy_setopt') { * }

    sub curl_easy_perform(LibCurl::EasyHandle) returns uint32
        is native(LIBCURL) { * }

    sub curl_easy_getinfo_long(LibCurl::EasyHandle, int32, long is rw)
	returns uint32 is native(LIBCURL) is symbol('curl_easy_getinfo') { * }

    sub curl_easy_getinfo_double(LibCurl::EasyHandle, int32, num64 is rw)
	returns uint32 is native(LIBCURL) is symbol('curl_easy_getinfo') { * }

    sub curl_easy_getinfo_str(LibCurl::EasyHandle, int32, CArray[Str])
	returns uint32 is native(LIBCURL) is symbol('curl_easy_getinfo') { * }

    method new() { curl_easy_init }

    method cleanup() { curl_easy_cleanup(self) }

    method reset() { curl_easy_reset(self) }

    method duphandle() { curl_easy_duphandle(self) }

    method version() { curl_version }

    method perform() { curl_easy_perform(self); }

    method setopt_str(Int $option, Str $param) {
        my $ret = curl_easy_setopt_str(self, $option, $param);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return $ret;
    }

    method setopt_long(Int $option, Int $param) {
        my $ret = curl_easy_setopt_long(self, $option, $param);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return $ret;
    }

    method setopt_cb(Int $option, &callback) {
        my $ret = curl_easy_setopt_cb(self, $option, &callback);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return $ret;
    }

    method setopt_ptr(Int $option, Pointer $ptr) {
        my $ret = curl_easy_setopt_ptr(self, $option, $ptr);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return $ret;
    }

    method getinfo_long(Int $option) {
        my long $value;
        my $ret = curl_easy_getinfo_long(self, $option, $value);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return $value;
    }

    method getinfo_double(Int $option) {
        my num64 $value;
        my $ret = curl_easy_getinfo_double(self, $option, $value);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return $value[0];
    }

    method getinfo_str(Int $option) {
        my $value = CArray[Str].new;
        $value[0] = '';
        my $ret = curl_easy_getinfo_str(self, $option, $value);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return $value[0];
    }
}

class LibCurl::Easy {
    has LibCurl::EasyHandle $.handle handles <cleanup version>;
    has %.receiveheaders;
    has $.statusline;
    has %.sendheaders;
    has Pointer $.header-slist;
    has Pointer $.upload-fh;
    has Pointer $.download-fh;
    has Buf $.sendbuf;
    has Int $.sendindex;
    has Buf $.buf;

    sub fopen(Str $path, Str $mode) returns Pointer is native { * }

    sub fclose(Pointer $fp) returns int32 is native { * }

    sub memcpy(Pointer $dest, CArray[int8], uint32 $n) is native { * }

    sub curl_slist_append(Pointer, Str)
        is native(LIBCURL) returns Pointer { * }

    sub curl_slist_free_all(Pointer) is native(LIBCURL) { * }

    method new(|opts)
    {
        my $self = self.bless(handle => LibCurl::EasyHandle.new);
        $self.setopt(|opts);
        $self.header-function;
        return $self;
    }

    method header-function()
    {
        sub callback(Pointer $ptr, uint32 $size, uint32 $nitems,
                     Pointer $userdata --> uint32)
        {
            my $bytes = nativecast(CArray[int8], $ptr);
            my $header = Buf.new($bytes[0 ..^ $size * $nitems]).decode;
            
            if $header ~~ /^HTTP\/1.1 /
            {
                $!statusline = $header.trim;
            }
            elsif $header ~~ /^(<-[:]>+) ': ' (.*)$/
            {
                %!receiveheaders{$0} = $1.trim;
            }

            return $size * $nitems;
        }
        $!handle.setopt_cb(CURLOPT_HEADERFUNCTION, &callback);
    }

    method content($encoding = 'utf-8') { $!buf.decode($encoding) }

    method setopt(*%options)
    {
        for %options.kv -> $option, $param
        {
            
            die "Unknown option $option" unless %opts{$option};

            my ($code, $type) = %opts{$option};

            given $type {
                when CURLOPT_BOOL {
                    $!handle.setopt_long($code, $param ?? 1 !! 0);
                }

                when CURLOPT_LONG {
                    $!handle.setopt_long($code, $param);
                }

                when CURLOPT_STR {
                    $!handle.setopt_str($code, $param);
                }

                when LIBCURL_HEADER {
                    self.set-header($option, $param);
                }

                when LIBCURL_DOWNLOAD {
                    $!download-fh = fopen($param, "wb");
                    $!handle.setopt_ptr(CURLOPT_WRITEDATA, $!download-fh);
                }

                when LIBCURL_UPLOAD {
                    $!upload-fh = fopen($param, "rb");
                    $!handle.setopt_long(CURLOPT_UPLOAD, 1);
                    $!handle.setopt_long(CURLOPT_INFILESIZE_LARGE,
                                         IO::Path.new($param).s);
                    $!handle.setopt_ptr(CURLOPT_READDATA, $!upload-fh);
                }

                when LIBCURL_SEND {
                    $!sendbuf = Buf.new($param.encode);
                    $!sendindex = 0;
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

    method get-header($field)
    {
        %!receiveheaders{$field};
    }

    method prepare()
    {
        if %!sendheaders.elems and !$!header-slist
        {
            for %!sendheaders.kv -> $header, $value {
                $!header-slist = curl_slist_append($!header-slist, 
                                                   "$header: $value");
            }
            $!handle.setopt_ptr(CURLOPT_HTTPHEADER, $!header-slist);
        }

        #
        # Download into buffer if download file not specified
        #
        unless $!download-fh 
        {
            $!buf = Buf.new;
            sub callback(Pointer $ptr, uint32 $size, uint32 $nmemb,
                         Pointer $userdata --> uint32)
            {
                my $bytes = nativecast(CArray[int8], $ptr);
                $!buf ~= Buf.new($bytes[0 ..^ $size * $nmemb]);
                return $size * $nmemb;
            }

            $!handle.setopt_cb(CURLOPT_WRITEFUNCTION, &callback);
        }

        #
        # Send from buffer if specified
        #
        if $!sendbuf
        {
            sub callback(Pointer $ptr, uint32 $size, uint32 $nmemb,
                         Pointer $userdata --> uint32)
            {
                return 0 if $!sendindex >= $!sendbuf.elems;

                my $tosend = min $!sendbuf.elems-$!sendindex,
                                 $size * $nmemb;

                my CArray[int8] $subbuf = 
                    CArray[int8].new($!sendbuf.subbuf($!sendindex, $tosend));

                memcpy($ptr, $subbuf, $tosend);

                $!sendindex += $tosend;

                return $tosend;
            }

            $!handle.setopt_long(CURLOPT_UPLOAD, 1);
            $!handle.setopt_long(CURLOPT_INFILESIZE_LARGE, $!sendbuf.elems);
            $!handle.setopt_cb(CURLOPT_READFUNCTION, &callback);
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
        given $type {
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
        return $_ with %!receiveheaders{$name};
        return self.getinfo($name) if %infofields{$name};
        return self.setopt(|($name => $param)) if %opts{$name};
        die "Unknown method $name";
    }

    submethod DESTROY
    {
        curl_slist_free_all($!header-slist) if $!header-slist;
        fclose($!download-fh) if $!download-fh;
        fclose($!upload-fh) if $!upload-fh;
        $!handle.cleanup;
    }
}
