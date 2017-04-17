use v6;

use NativeCall;

constant LIBCURL = "curl";

constant CURLE_OK                           = 0;

constant CURL_ERROR_SIZE                    = 256;

constant CURL_GLOBAL_DEFAULT                = 0x3;

constant CURL_NETRC_IGNORED                 = 0;
constant CURL_NETRC_OPTIONAL                = 1;
constant CURL_NETRC_REQUIRED                = 2;

constant CURLPROXY_HTTP                     = 0;
constant CURLPROXY_HTTP_1_0                 = 1;
constant CURLPROXY_SOCKS4                   = 4;
constant CURLPROXY_SOCKS5                   = 5;
constant CURLPROXY_SOCKS4A                  = 6;
constant CURLPROXY_SOCKS5_HOSTNAME          = 7;

constant CURLUSESSL_NONE                    = 0;
constant CURLUSESSL_TRY                     = 1;
constant CURLUSESSL_CONTROL                 = 2;
constant CURLUSESSL_ALL                     = 3;

constant CURLINFO_STRING                    = 0x100000;
constant CURLINFO_LONG                      = 0x200000;
constant CURLINFO_DOUBLE                    = 0x300000;
constant CURLINFO_SLIST                     = 0x400000;

constant CURLINFO_EFFECTIVE_URL             = CURLINFO_STRING + 1;
constant CURLINFO_RESPONSE_CODE             = CURLINFO_LONG   + 2;
constant CURLINFO_TOTAL_TIME                = CURLINFO_DOUBLE + 3;
constant CURLINFO_NAMELOOKUP_TIME           = CURLINFO_DOUBLE + 4;
constant CURLINFO_CONNECT_TIME              = CURLINFO_DOUBLE + 5;
constant CURLINFO_PRETRANSFER_TIME          = CURLINFO_DOUBLE + 6;
constant CURLINFO_SIZE_UPLOAD               = CURLINFO_DOUBLE + 7;
constant CURLINFO_SIZE_DOWNLOAD             = CURLINFO_DOUBLE + 8;
constant CURLINFO_SPEED_DOWNLOAD            = CURLINFO_DOUBLE + 9;
constant CURLINFO_SPEED_UPLOAD              = CURLINFO_DOUBLE + 10;
constant CURLINFO_HEADER_SIZE               = CURLINFO_LONG   + 11;
constant CURLINFO_REQUEST_SIZE              = CURLINFO_LONG   + 12;
constant CURLINFO_SSL_VERIFYRESULT          = CURLINFO_LONG   + 13;
constant CURLINFO_FILETIME                  = CURLINFO_LONG   + 14;
constant CURLINFO_CONTENT_LENGTH_DOWNLOAD   = CURLINFO_DOUBLE + 15;
constant CURLINFO_CONTENT_LENGTH_UPLOAD     = CURLINFO_DOUBLE + 16;
constant CURLINFO_STARTTRANSFER_TIME        = CURLINFO_DOUBLE + 17;
constant CURLINFO_CONTENT_TYPE              = CURLINFO_STRING + 18;
constant CURLINFO_REDIRECT_TIME             = CURLINFO_DOUBLE + 19;
constant CURLINFO_REDIRECT_COUNT            = CURLINFO_LONG   + 20;
constant CURLINFO_PRIVATE                   = CURLINFO_STRING + 21;
constant CURLINFO_HTTP_CONNECTCODE          = CURLINFO_LONG   + 22;
constant CURLINFO_HTTPAUTH_AVAIL            = CURLINFO_LONG   + 23;
constant CURLINFO_PROXYAUTH_AVAIL           = CURLINFO_LONG   + 24;
constant CURLINFO_OS_ERRNO                  = CURLINFO_LONG   + 25;
constant CURLINFO_NUM_CONNECTS              = CURLINFO_LONG   + 26;
constant CURLINFO_SSL_ENGINES               = CURLINFO_SLIST  + 27;
constant CURLINFO_COOKIELIST                = CURLINFO_SLIST  + 28;
constant CURLINFO_LASTSOCKET                = CURLINFO_LONG   + 29;
constant CURLINFO_FTP_ENTRY_PATH            = CURLINFO_STRING + 30;
constant CURLINFO_REDIRECT_URL              = CURLINFO_STRING + 31;
constant CURLINFO_PRIMARY_IP                = CURLINFO_STRING + 32;
constant CURLINFO_APPCONNECT_TIME           = CURLINFO_DOUBLE + 33;
constant CURLINFO_CERTINFO                  = CURLINFO_SLIST  + 34;
constant CURLINFO_CONDITION_UNMET           = CURLINFO_LONG   + 35;
constant CURLINFO_RTSP_SESSION_ID           = CURLINFO_STRING + 36;
constant CURLINFO_RTSP_CLIENT_CSEQ          = CURLINFO_LONG   + 37;
constant CURLINFO_RTSP_SERVER_CSEQ          = CURLINFO_LONG   + 38;
constant CURLINFO_RTSP_CSEQ_RECV            = CURLINFO_LONG   + 39;
constant CURLINFO_PRIMARY_PORT              = CURLINFO_LONG   + 40;
constant CURLINFO_LOCAL_IP                  = CURLINFO_STRING + 41;
constant CURLINFO_LOCAL_PORT                = CURLINFO_LONG   + 42;
constant CURLINFO_TLS_SESSION               = CURLINFO_SLIST  + 43;

constant CURLOPTTYPE_LONG                   = 0;
constant CURLOPTTYPE_OBJECTPOINT            = 10000;
constant CURLOPTTYPE_FUNCTIONPOINT          = 20000;
constant CURLOPTTYPE_OFF_T                  = 30000;

constant CURLOPT_FILE                       = CURLOPTTYPE_OBJECTPOINT   + 1;
constant CURLOPT_URL                        = CURLOPTTYPE_OBJECTPOINT   + 2;
constant CURLOPT_PORT                       = CURLOPTTYPE_LONG          + 3;
constant CURLOPT_PROXY                      = CURLOPTTYPE_OBJECTPOINT   + 4;
constant CURLOPT_USERPWD                    = CURLOPTTYPE_OBJECTPOINT   + 5;
constant CURLOPT_PROXYUSERPWD               = CURLOPTTYPE_OBJECTPOINT   + 6;
constant CURLOPT_RANGE                      = CURLOPTTYPE_OBJECTPOINT   + 7;
constant CURLOPT_INFILE                     = CURLOPTTYPE_OBJECTPOINT   + 9;
constant CURLOPT_ERRORBUFFER                = CURLOPTTYPE_OBJECTPOINT   + 10;
constant CURLOPT_WRITEFUNCTION              = CURLOPTTYPE_FUNCTIONPOINT + 11;
constant CURLOPT_READFUNCTION               = CURLOPTTYPE_FUNCTIONPOINT + 12;
constant CURLOPT_TIMEOUT                    = CURLOPTTYPE_LONG          + 13;
constant CURLOPT_INFILESIZE                 = CURLOPTTYPE_LONG          + 14;
constant CURLOPT_POSTFIELDS                 = CURLOPTTYPE_OBJECTPOINT   + 15;
constant CURLOPT_REFERER                    = CURLOPTTYPE_OBJECTPOINT   + 16;
constant CURLOPT_FTPPORT                    = CURLOPTTYPE_OBJECTPOINT   + 17;
constant CURLOPT_USERAGENT                  = CURLOPTTYPE_OBJECTPOINT   + 18;
constant CURLOPT_LOW_SPEED_LIMIT            = CURLOPTTYPE_LONG          + 19;
constant CURLOPT_LOW_SPEED_TIME             = CURLOPTTYPE_LONG          + 20;
constant CURLOPT_RESUME_FROM                = CURLOPTTYPE_LONG          + 21;
constant CURLOPT_COOKIE                     = CURLOPTTYPE_OBJECTPOINT   + 22;
constant CURLOPT_HTTPHEADER                 = CURLOPTTYPE_OBJECTPOINT   + 23;
constant CURLOPT_HTTPPOST                   = CURLOPTTYPE_OBJECTPOINT   + 24;
constant CURLOPT_SSLCERT                    = CURLOPTTYPE_OBJECTPOINT   + 25;
constant CURLOPT_KEYPASSWD                  = CURLOPTTYPE_OBJECTPOINT   + 26;
constant CURLOPT_CRLF                       = CURLOPTTYPE_LONG          + 27;
constant CURLOPT_QUOTE                      = CURLOPTTYPE_OBJECTPOINT   + 28;
constant CURLOPT_WRITEHEADER                = CURLOPTTYPE_OBJECTPOINT   + 29;
constant CURLOPT_COOKIEFILE                 = CURLOPTTYPE_OBJECTPOINT   + 31;
constant CURLOPT_SSLVERSION                 = CURLOPTTYPE_LONG          + 32;
constant CURLOPT_TIMECONDITION              = CURLOPTTYPE_LONG          + 33;
constant CURLOPT_TIMEVALUE                  = CURLOPTTYPE_LONG          + 34;
constant CURLOPT_CUSTOMREQUEST              = CURLOPTTYPE_OBJECTPOINT   + 36;
constant CURLOPT_STDERR                     = CURLOPTTYPE_OBJECTPOINT   + 37;
constant CURLOPT_POSTQUOTE                  = CURLOPTTYPE_OBJECTPOINT   + 39;
constant CURLOPT_WRITEINFO                  = CURLOPTTYPE_OBJECTPOINT   + 40;
constant CURLOPT_VERBOSE                    = CURLOPTTYPE_LONG          + 41;
constant CURLOPT_HEADER                     = CURLOPTTYPE_LONG          + 42;
constant CURLOPT_NOPROGRESS                 = CURLOPTTYPE_LONG          + 43;
constant CURLOPT_NOBODY                     = CURLOPTTYPE_LONG          + 44;
constant CURLOPT_FAILONERROR                = CURLOPTTYPE_LONG          + 45;
constant CURLOPT_UPLOAD                     = CURLOPTTYPE_LONG          + 46;
constant CURLOPT_POST                       = CURLOPTTYPE_LONG          + 47;
constant CURLOPT_DIRLISTONLY                = CURLOPTTYPE_LONG          + 48;
constant CURLOPT_APPEND                     = CURLOPTTYPE_LONG          + 50;
constant CURLOPT_NETRC                      = CURLOPTTYPE_LONG          + 51;
constant CURLOPT_FOLLOWLOCATION             = CURLOPTTYPE_LONG          + 52;
constant CURLOPT_TRANSFERTEXT               = CURLOPTTYPE_LONG          + 53;
constant CURLOPT_PUT                        = CURLOPTTYPE_LONG          + 54;
constant CURLOPT_PROGRESSFUNCTION           = CURLOPTTYPE_FUNCTIONPOINT + 56;
constant CURLOPT_PROGRESSDATA               = CURLOPTTYPE_OBJECTPOINT   + 57;
constant CURLOPT_AUTOREFERER                = CURLOPTTYPE_LONG          + 58;
constant CURLOPT_PROXYPORT                  = CURLOPTTYPE_LONG          + 59;
constant CURLOPT_POSTFIELDSIZE              = CURLOPTTYPE_LONG          + 60;
constant CURLOPT_HTTPPROXYTUNNEL            = CURLOPTTYPE_LONG          + 61;
constant CURLOPT_INTERFACE                  = CURLOPTTYPE_OBJECTPOINT   + 62;
constant CURLOPT_KRBLEVEL                   = CURLOPTTYPE_OBJECTPOINT   + 63;
constant CURLOPT_SSL_VERIFYPEER             = CURLOPTTYPE_LONG          + 64;
constant CURLOPT_CAINFO                     = CURLOPTTYPE_OBJECTPOINT   + 65;
constant CURLOPT_MAXREDIRS                  = CURLOPTTYPE_LONG          + 68;
constant CURLOPT_FILETIME                   = CURLOPTTYPE_LONG          + 69;
constant CURLOPT_TELNETOPTIONS              = CURLOPTTYPE_OBJECTPOINT   + 70;
constant CURLOPT_MAXCONNECTS                = CURLOPTTYPE_LONG          + 71;
constant CURLOPT_CLOSEPOLICY                = CURLOPTTYPE_LONG          + 72;
constant CURLOPT_FRESH_CONNECT              = CURLOPTTYPE_LONG          + 74;
constant CURLOPT_FORBID_REUSE               = CURLOPTTYPE_LONG          + 75;
constant CURLOPT_RANDOM_FILE                = CURLOPTTYPE_OBJECTPOINT   + 76;
constant CURLOPT_EGDSOCKET                  = CURLOPTTYPE_OBJECTPOINT   + 77;
constant CURLOPT_CONNECTTIMEOUT             = CURLOPTTYPE_LONG          + 78;
constant CURLOPT_HEADERFUNCTION             = CURLOPTTYPE_FUNCTIONPOINT + 79;
constant CURLOPT_HTTPGET                    = CURLOPTTYPE_LONG          + 80;
constant CURLOPT_SSL_VERIFYHOST             = CURLOPTTYPE_LONG          + 81;
constant CURLOPT_COOKIEJAR                  = CURLOPTTYPE_OBJECTPOINT   + 82;
constant CURLOPT_SSL_CIPHER_LIST            = CURLOPTTYPE_OBJECTPOINT   + 83;
constant CURLOPT_HTTP_VERSION               = CURLOPTTYPE_LONG          + 84;
constant CURLOPT_FTP_USE_EPSV               = CURLOPTTYPE_LONG          + 85;
constant CURLOPT_SSLCERTTYPE                = CURLOPTTYPE_OBJECTPOINT   + 86;
constant CURLOPT_SSLKEY                     = CURLOPTTYPE_OBJECTPOINT   + 87;
constant CURLOPT_SSLKEYTYPE                 = CURLOPTTYPE_OBJECTPOINT   + 88;
constant CURLOPT_SSLENGINE                  = CURLOPTTYPE_OBJECTPOINT   + 89;
constant CURLOPT_SSLENGINE_DEFAULT          = CURLOPTTYPE_LONG          + 90;
constant CURLOPT_DNS_CACHE_TIMEOUT          = CURLOPTTYPE_LONG          + 92;
constant CURLOPT_PREQUOTE                   = CURLOPTTYPE_OBJECTPOINT   + 93;
constant CURLOPT_DEBUGFUNCTION              = CURLOPTTYPE_FUNCTIONPOINT + 94;
constant CURLOPT_DEBUGDATA                  = CURLOPTTYPE_OBJECTPOINT   + 95;
constant CURLOPT_COOKIESESSION              = CURLOPTTYPE_LONG          + 96;
constant CURLOPT_CAPATH                     = CURLOPTTYPE_OBJECTPOINT   + 97;
constant CURLOPT_BUFFERSIZE                 = CURLOPTTYPE_LONG          + 98;
constant CURLOPT_NOSIGNAL                   = CURLOPTTYPE_LONG          + 99;
constant CURLOPT_SHARE                      = CURLOPTTYPE_OBJECTPOINT   + 100;
constant CURLOPT_PROXYTYPE                  = CURLOPTTYPE_LONG          + 101;
constant CURLOPT_ACCEPT_ENCODING            = CURLOPTTYPE_OBJECTPOINT   + 102;
constant CURLOPT_PRIVATE                    = CURLOPTTYPE_OBJECTPOINT   + 103;
constant CURLOPT_HTTP200ALIASES             = CURLOPTTYPE_OBJECTPOINT   + 104;
constant CURLOPT_UNRESTRICTED_AUTH          = CURLOPTTYPE_LONG          + 105;
constant CURLOPT_FTP_USE_EPRT               = CURLOPTTYPE_LONG          + 106;
constant CURLOPT_HTTPAUTH                   = CURLOPTTYPE_LONG          + 107;
constant CURLOPT_SSL_CTX_FUNCTION           = CURLOPTTYPE_FUNCTIONPOINT + 108;
constant CURLOPT_SSL_CTX_DATA               = CURLOPTTYPE_OBJECTPOINT   + 109;
constant CURLOPT_PROXYAUTH                  = CURLOPTTYPE_LONG          + 111;
constant CURLOPT_FTP_RESPONSE_TIMEOUT       = CURLOPTTYPE_LONG          + 112;
constant CURLOPT_IPRESOLVE                  = CURLOPTTYPE_LONG          + 113;
constant CURLOPT_MAXFILESIZE                = CURLOPTTYPE_LONG          + 114;
constant CURLOPT_INFILESIZE_LARGE           = CURLOPTTYPE_OFF_T         + 115;
constant CURLOPT_RESUME_FROM_LARGE          = CURLOPTTYPE_OFF_T         + 116;
constant CURLOPT_MAXFILESIZE_LARGE          = CURLOPTTYPE_OFF_T         + 117;
constant CURLOPT_NETRC_FILE                 = CURLOPTTYPE_OBJECTPOINT   + 118;
constant CURLOPT_USE_SSL                    = CURLOPTTYPE_LONG          + 119;
constant CURLOPT_POSTFIELDSIZE_LARGE        = CURLOPTTYPE_OFF_T         + 120;
constant CURLOPT_TCP_NODELAY                = CURLOPTTYPE_LONG          + 121;
constant CURLOPT_FTPSSLAUTH                 = CURLOPTTYPE_LONG          + 129;
constant CURLOPT_IOCTLFUNCTION              = CURLOPTTYPE_FUNCTIONPOINT + 130;
constant CURLOPT_IOCTLDATA                  = CURLOPTTYPE_OBJECTPOINT   + 131;
constant CURLOPT_FTP_ACCOUNT                = CURLOPTTYPE_OBJECTPOINT   + 134;
constant CURLOPT_COOKIELIST                 = CURLOPTTYPE_OBJECTPOINT   + 135;
constant CURLOPT_IGNORE_CONTENT_LENGTH      = CURLOPTTYPE_LONG          + 136;
constant CURLOPT_FTP_SKIP_PASV_IP           = CURLOPTTYPE_LONG          + 137;
constant CURLOPT_FTP_FILEMETHOD             = CURLOPTTYPE_LONG          + 138;
constant CURLOPT_LOCALPORT                  = CURLOPTTYPE_LONG          + 139;
constant CURLOPT_LOCALPORTRANGE             = CURLOPTTYPE_LONG          + 140;
constant CURLOPT_CONNECT_ONLY               = CURLOPTTYPE_LONG          + 141;
constant CURLOPT_FTP_CREATE_MISSING_DIRS    = CURLOPTTYPE_LONG          + 110;
constant CURLOPT_CONV_FROM_NETWORK_FUNCTION = CURLOPTTYPE_FUNCTIONPOINT + 142;
constant CURLOPT_CONV_TO_NETWORK_FUNCTION   = CURLOPTTYPE_FUNCTIONPOINT + 143;
constant CURLOPT_CONV_FROM_UTF8_FUNCTION    = CURLOPTTYPE_FUNCTIONPOINT + 144;
constant CURLOPT_MAX_SEND_SPEED_LARGE       = CURLOPTTYPE_OFF_T         + 145;
constant CURLOPT_MAX_RECV_SPEED_LARGE       = CURLOPTTYPE_OFF_T         + 146;
constant CURLOPT_FTP_ALTERNATIVE_TO_USER    = CURLOPTTYPE_OBJECTPOINT   + 147;
constant CURLOPT_SSH_HOST_PUBLIC_KEY_MD5    = CURLOPTTYPE_OBJECTPOINT   + 162;
constant CURLOPT_HTTP_TRANSFER_DECODING     = CURLOPTTYPE_LONG          + 157;
constant CURLOPT_SOCKOPTFUNCTION            = CURLOPTTYPE_FUNCTIONPOINT + 148;
constant CURLOPT_SOCKOPTDATA                = CURLOPTTYPE_OBJECTPOINT   + 149;
constant CURLOPT_SSL_SESSIONID_CACHE        = CURLOPTTYPE_LONG          + 150;
constant CURLOPT_SSH_AUTH_TYPES             = CURLOPTTYPE_LONG          + 151;
constant CURLOPT_SSH_PUBLIC_KEYFILE         = CURLOPTTYPE_OBJECTPOINT   + 152;
constant CURLOPT_SSH_PRIVATE_KEYFILE        = CURLOPTTYPE_OBJECTPOINT   + 153;
constant CURLOPT_FTP_SSL_CCC                = CURLOPTTYPE_LONG          + 154;
constant CURLOPT_TIMEOUT_MS                 = CURLOPTTYPE_LONG          + 155;
constant CURLOPT_CONNECTTIMEOUT_MS          = CURLOPTTYPE_LONG          + 156;
constant CURLOPT_HTTP_CONTENT_DECODING      = CURLOPTTYPE_LONG          + 158;
constant CURLOPT_NEW_FILE_PERMS             = CURLOPTTYPE_LONG          + 159;
constant CURLOPT_NEW_DIRECTORY_PERMS        = CURLOPTTYPE_LONG          + 160;
constant CURLOPT_POSTREDIR                  = CURLOPTTYPE_LONG          + 161;
constant CURLOPT_OPENSOCKETFUNCTION         = CURLOPTTYPE_FUNCTIONPOINT + 163;
constant CURLOPT_OPENSOCKETDATA             = CURLOPTTYPE_OBJECTPOINT   + 164;
constant CURLOPT_COPYPOSTFIELDS             = CURLOPTTYPE_OBJECTPOINT   + 165;
constant CURLOPT_PROXY_TRANSFER_MODE        = CURLOPTTYPE_LONG          + 166;
constant CURLOPT_SEEKFUNCTION               = CURLOPTTYPE_FUNCTIONPOINT + 167;
constant CURLOPT_SEEKDATA                   = CURLOPTTYPE_OBJECTPOINT   + 168;
constant CURLOPT_CRLFILE                    = CURLOPTTYPE_OBJECTPOINT   + 169;
constant CURLOPT_ISSUERCERT                 = CURLOPTTYPE_OBJECTPOINT   + 170;
constant CURLOPT_ADDRESS_SCOPE              = CURLOPTTYPE_LONG          + 171;
constant CURLOPT_CERTINFO                   = CURLOPTTYPE_LONG          + 172;
constant CURLOPT_USERNAME                   = CURLOPTTYPE_OBJECTPOINT   + 173;
constant CURLOPT_PASSWORD                   = CURLOPTTYPE_OBJECTPOINT   + 174;
constant CURLOPT_PROXYUSERNAME              = CURLOPTTYPE_OBJECTPOINT   + 175;
constant CURLOPT_PROXYPASSWORD              = CURLOPTTYPE_OBJECTPOINT   + 176;
constant CURLOPT_NOPROXY                    = CURLOPTTYPE_OBJECTPOINT   + 177;
constant CURLOPT_TFTP_BLKSIZE               = CURLOPTTYPE_LONG          + 178;
constant CURLOPT_SOCKS5_GSSAPI_SERVICE      = CURLOPTTYPE_OBJECTPOINT   + 179;
constant CURLOPT_SOCKS5_GSSAPI_NEC          = CURLOPTTYPE_LONG          + 180;
constant CURLOPT_PROTOCOLS                  = CURLOPTTYPE_LONG          + 181;
constant CURLOPT_REDIR_PROTOCOLS            = CURLOPTTYPE_LONG          + 182;
constant CURLOPT_SSH_KNOWNHOSTS             = CURLOPTTYPE_OBJECTPOINT   + 183;
constant CURLOPT_SSH_KEYFUNCTION            = CURLOPTTYPE_FUNCTIONPOINT + 184;
constant CURLOPT_SSH_KEYDATA                = CURLOPTTYPE_OBJECTPOINT   + 185;
constant CURLOPT_MAIL_FROM                  = CURLOPTTYPE_OBJECTPOINT   + 186;
constant CURLOPT_MAIL_RCPT                  = CURLOPTTYPE_OBJECTPOINT   + 187;
constant CURLOPT_FTP_USE_PRET               = CURLOPTTYPE_LONG          + 188;
constant CURLOPT_RTSP_REQUEST               = CURLOPTTYPE_LONG          + 189;
constant CURLOPT_RTSP_SESSION_ID            = CURLOPTTYPE_OBJECTPOINT   + 190;
constant CURLOPT_RTSP_STREAM_URI            = CURLOPTTYPE_OBJECTPOINT   + 191;
constant CURLOPT_RTSP_TRANSPORT             = CURLOPTTYPE_OBJECTPOINT   + 192;
constant CURLOPT_RTSP_CLIENT_CSEQ           = CURLOPTTYPE_LONG          + 193;
constant CURLOPT_RTSP_SERVER_CSEQ           = CURLOPTTYPE_LONG          + 194;
constant CURLOPT_INTERLEAVEDATA             = CURLOPTTYPE_OBJECTPOINT   + 195;
constant CURLOPT_INTERLEAVEFUNCTION         = CURLOPTTYPE_FUNCTIONPOINT + 196;
constant CURLOPT_WILDCARDMATCH              = CURLOPTTYPE_LONG          + 197;
constant CURLOPT_CHUNK_BGN_FUNCTION         = CURLOPTTYPE_FUNCTIONPOINT + 198;
constant CURLOPT_CHUNK_END_FUNCTION         = CURLOPTTYPE_FUNCTIONPOINT + 199;
constant CURLOPT_FNMATCH_FUNCTION           = CURLOPTTYPE_FUNCTIONPOINT + 200;
constant CURLOPT_CHUNK_DATA                 = CURLOPTTYPE_OBJECTPOINT   + 201;
constant CURLOPT_FNMATCH_DATA               = CURLOPTTYPE_OBJECTPOINT   + 202;
constant CURLOPT_RESOLVE                    = CURLOPTTYPE_OBJECTPOINT   + 203;
constant CURLOPT_TLSAUTH_USERNAME           = CURLOPTTYPE_OBJECTPOINT   + 204;
constant CURLOPT_TLSAUTH_PASSWORD           = CURLOPTTYPE_OBJECTPOINT   + 205;
constant CURLOPT_TLSAUTH_TYPE               = CURLOPTTYPE_OBJECTPOINT   + 206;
constant CURLOPT_TRANSFER_ENCODING          = CURLOPTTYPE_LONG          + 207;
constant CURLOPT_CLOSESOCKETFUNCTION        = CURLOPTTYPE_FUNCTIONPOINT + 208;
constant CURLOPT_CLOSESOCKETDATA            = CURLOPTTYPE_OBJECTPOINT   + 209;
constant CURLOPT_GSSAPI_DELEGATION          = CURLOPTTYPE_LONG          + 210;
constant CURLOPT_DNS_SERVERS                = CURLOPTTYPE_OBJECTPOINT   + 211;
constant CURLOPT_ACCEPTTIMEOUT_MS           = CURLOPTTYPE_LONG          + 212;
constant CURLOPT_TCP_KEEPALIVE              = CURLOPTTYPE_LONG          + 213;
constant CURLOPT_TCP_KEEPIDLE               = CURLOPTTYPE_LONG          + 214;
constant CURLOPT_TCP_KEEPINTVL              = CURLOPTTYPE_LONG          + 215;
constant CURLOPT_SSL_OPTIONS                = CURLOPTTYPE_LONG          + 216;
constant CURLOPT_MAIL_AUTH                  = CURLOPTTYPE_OBJECTPOINT   + 217;
constant CURLOPT_XFERINFOFUNCTION           = CURLOPTTYPE_FUNCTIONPOINT + 219;
constant CURLOPT_XOAUTH2_BEARER             = CURLOPTTYPE_OBJECTPOINT   + 220;
constant CURLOPT_DNS_INTERFACE              = CURLOPTTYPE_OBJECTPOINT   + 221;
constant CURLOPT_DNS_LOCAL_IP4              = CURLOPTTYPE_OBJECTPOINT   + 222;
constant CURLOPT_DNS_LOCAL_IP6              = CURLOPTTYPE_OBJECTPOINT   + 223;
constant CURLOPT_LOGIN_OPTIONS              = CURLOPTTYPE_OBJECTPOINT   + 224;

constant CURLOPT_READDATA                   = CURLOPT_INFILE;
constant CURLOPT_WRITEDATA                  = CURLOPT_FILE;
constant CURLOPT_HEADERDATA                 = CURLOPT_WRITEHEADER;
constant CURLOPT_RTSPHEADER                 = CURLOPT_HTTPHEADER;
constant CURLOPT_XFERINFODATA               = CURLOPT_PROGRESSDATA;
constant CURLOPT_POST301                    = CURLOPT_POSTREDIR;
constant CURLOPT_SERVER_RESPONSE_TIMEOUT    = CURLOPT_FTP_RESPONSE_TIMEOUT;
constant CURLOPT_SSLKEYPASSWD               = CURLOPT_KEYPASSWD;
constant CURLOPT_FTPAPPEND                  = CURLOPT_APPEND;
constant CURLOPT_FTPLISTONLY                = CURLOPT_DIRLISTONLY;
constant CURLOPT_FTP_SSL                    = CURLOPT_USE_SSL;
constant CURLOPT_SSLCERTPASSWD              = CURLOPT_KEYPASSWD;
constant CURLOPT_KRB4LEVEL                  = CURLOPT_KRBLEVEL;

sub curl_global_init(int32) returns uint32 is native(LIBCURL) is export { * }

sub curl_global_cleanup() is native(LIBCURL) is export { * }

sub curl_version() returns Str is native(LIBCURL) is export { * }

class X::LibCurl is Exception
{
    has Int $.code;

    sub curl_easy_strerror(uint32) returns Str is native(LIBCURL) { * }

    method Int() { $!code }

    method message() { curl_easy_strerror($!code) }
}

class LibCurl::slist is repr('CPointer')
{
    sub curl_slist_append(LibCurl::slist, Str) returns LibCurl::slist
        is native(LIBCURL) { * }

    sub curl_slist_free_all(LibCurl::slist) is native(LIBCURL) { * }

    sub new(@str-list)
    {
        my $self = LibCurl::slist;
        $self = $self.append($_) for @str-list;
    }

    method append(Str $str)
    {
        curl_slist_append(self, $str);
    }

    method free
    {
        curl_slist_free_all(self);
    }
}

class LibCurl::EasyHandle is repr('CPointer')
{
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

    sub curl_easy_setopt_slist(LibCurl::EasyHandle, uint32, LibCurl::slist)
        returns uint32 is native(LIBCURL) is symbol('curl_easy_setopt') { * }

    sub curl_easy_setopt_array(LibCurl::EasyHandle, uint32, CArray[int8])
        returns uint32 is native(LIBCURL) is symbol('curl_easy_setopt') { * }

    sub curl_easy_setopt_data-cb(LibCurl::EasyHandle, uint32,
        &cb (Pointer, uint32, uint32, Pointer --> uint32))
        returns uint32 is native(LIBCURL) is symbol('curl_easy_setopt') { * }

    sub curl_easy_setopt_debug-cb(LibCurl::EasyHandle, uint32,
	&cb (Pointer, uint32, Pointer, size_t, Pointer --> int32))
        returns uint32 is native(LIBCURL) is symbol('curl_easy_setopt') { * }

    sub curl_easy_setopt_xfer-cb(LibCurl::EasyHandle, uint32,
	&cb (Pointer, long, long, long, long --> int32))
        returns uint32 is native(LIBCURL) is symbol('curl_easy_setopt') { * }

    sub curl_easy_perform(LibCurl::EasyHandle) returns uint32
        is native(LIBCURL) { * }

    sub curl_easy_getinfo_long(LibCurl::EasyHandle, int32, long is rw)
        returns uint32 is native(LIBCURL) is symbol('curl_easy_getinfo') { * }

    sub curl_easy_getinfo_double(LibCurl::EasyHandle, int32, num64 is rw)
        returns uint32 is native(LIBCURL) is symbol('curl_easy_getinfo') { * }

    sub curl_easy_getinfo_str(LibCurl::EasyHandle, int32, CArray[Str])
        returns uint32 is native(LIBCURL) is symbol('curl_easy_getinfo') { * }

    sub sprintf-pointer(CArray[int8], Str, Pointer) returns int32
        is symbol('sprintf') is native { * }

    method new() { curl_easy_init }

    method id() {
        my $id = CArray[int8].new;
        $id[20] = 0;
        sprintf-pointer($id, "%p", self);
        return nativecast(Str, $id);
    }

    method cleanup() { curl_easy_cleanup(self) }

    method reset() { curl_easy_reset(self) }

    method duphandle() { curl_easy_duphandle(self) }

    method perform() { curl_easy_perform(self); }

    multi method setopt(Int $option, Str $param) {
        my $ret = curl_easy_setopt_str(self, $option, $param);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return $ret;
    }

    multi method setopt(Int $option, Int $param) {
        my $ret = curl_easy_setopt_long(self, $option, $param);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return $ret;
    }

    multi method setopt(Int $option, &callback) {
        my $ret = do given $option {
	   when CURLOPT_WRITEFUNCTION | CURLOPT_READFUNCTION |
	        CURLOPT_HEADERFUNCTION {
	       curl_easy_setopt_data-cb(self, $option, &callback);
	   }
	   when CURLOPT_DEBUGFUNCTION {
	       curl_easy_setopt_debug-cb(self, $option, &callback);
	   }
	   when CURLOPT_XFERINFOFUNCTION {
	       curl_easy_setopt_xfer-cb(self, $option, &callback);
	   }
	};
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return $ret;
    }

    multi method setopt(Int $option, Pointer $ptr) {
        my $ret = curl_easy_setopt_ptr(self, $option, $ptr);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return $ret;
    }

    multi method setopt(Int $option, LibCurl::slist $slist) {
        my $ret = curl_easy_setopt_slist(self, $option, $slist);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return $ret;
    }

    multi method setopt(Int $option, CArray[int8] $ptr) {
        my $ret = curl_easy_setopt_array(self, $option, $ptr);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return $ret;
    }

    multi method setopt(Int $option, LibCurl::EasyHandle $ptr) {
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
