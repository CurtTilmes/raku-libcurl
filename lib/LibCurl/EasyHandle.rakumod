use NativeLibs:ver<0.0.7+>:auth<github:salortiz>;

constant LIBCURL = NativeLibs::Searcher.at-runtime('curl', 'curl_version', 4);

constant intptr = ssize_t;

enum CURL_HTTP_VERSION_ENUM <
    CURL_HTTP_VERSION_NONE
    CURL_HTTP_VERSION_1_0
    CURL_HTTP_VERSION_1_1
    CURL_HTTP_VERSION_2_0
>;

enum CURL-INFO-TYPE <
    CURLINFO_TEXT
    CURLINFO_HEADER_IN
    CURLINFO_HEADER_OUT
    CURLINFO_DATA_IN
    CURLINFO_DATA_OUT
    CURLINFO_SSL_DATA_IN
    CURLINFO_SSL_DATA_OUT
>;

enum CURLAUTH (
    CURLAUTH_NONE         => 0,
    CURLAUTH_BASIC        => 1,
    CURLAUTH_DIGEST       => 1 +< 1,
    CURLAUTH_GSSNEGOTIATE => 1 +< 2,
    CURLAUTH_NTLM         => 1 +< 3,
    CURLAUTH_DIGEST_IE    => 1 +< 4,
    CURLAUTH_NTLM_WB      => 1 +< 5,
    CURLAUTH_BEARER       => 1 +< 6,
    CURLAUTH_ONLY         => 1 +< 31,
);

constant CURLAUTH_ANY     = +^CURLAUTH_DIGEST_IE;
constant CURLAUTH_ANYSAFE = +^(CURLAUTH_BASIC +| CURLAUTH_DIGEST_IE);

enum CURL_NETRC <
    CURL_NETRC_IGNORED
    CURL_NETRC_OPTIONAL
    CURL_NETRC_REQUIRED
>;

enum CURL_TIMECOND <
    CURL_TIMECOND_NONE
    CURL_TIMECOND_IFMODSINCE
    CURL_TIMECOND_IFUNMODSINCE
    CURL_TIMECOND_LASTMOD
>;

enum CURLPROXY (
    CURLPROXY_HTTP             => 0,
    CURLPROXY_HTTP_1_0         => 1,
    CURLPROXY_HTTPS            => 2,
    CURLPROXY_SOCKS4           => 4,
    CURLPROXY_SOCKS5           => 5,
    CURLPROXY_SOCKS4A          => 6,
    CURLPROXY_SOCKS5_HOSTNAME  => 7,
);

enum CURLUSESSL <
    CURLUSESSL_NONE
    CURLUSESSL_TRY
    CURLUSESSL_CONTROL
    CURLUSESSL_ALL
>;

enum CURL_VERSION_FEATURE (
    CURL_VERSION_IPV6             => 1,
    CURL_VERSION_KERBEROS4        => 1 +< 1,
    CURL_VERSION_SSL              => 1 +< 2,
    CURL_VERSION_LIBZ             => 1 +< 3,
    CURL_VERSION_NTLM             => 1 +< 4,
    CURL_VERSION_GSSNEGOTIATE     => 1 +< 5,
    CURL_VERSION_DEBUG            => 1 +< 6,
    CURL_VERSION_ASYNCHDNS        => 1 +< 7,
    CURL_VERSION_SPNEGO           => 1 +< 8,
    CURL_VERSION_LARGEFILE        => 1 +< 9,
    CURL_VERSION_IDN              => 1 +< 10,
    CURL_VERSION_SSPI             => 1 +< 11,
    CURL_VERSION_CONV             => 1 +< 12,
    CURL_VERSION_CURLDEBUG        => 1 +< 13,
    CURL_VERSION_TLSAUTH_SRP      => 1 +< 14,
    CURL_VERSION_NTLM_WB          => 1 +< 15,
    CURL_VERSION_HTTP2            => 1 +< 16
);

enum CURLversion <
    CURLVERSION_FIRST
    CURLVERSION_SECOND
    CURLVERSION_THIRD
    CURLVERSION_FOURTH
>;

constant CURLVERSION_NOW = CURLVERSION_FOURTH;

enum CURLcode <
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
>;

constant CURL_ERROR_SIZE                    = 256;

constant CURL_GLOBAL_SSL                    = 1;
constant CURL_GLOBAL_WIN32                  = 1 +< 1;
constant CURL_GLOBAL_ALL                    = CURL_GLOBAL_SSL +|
                                              CURL_GLOBAL_WIN32;
constant CURL_GLOBAL_NOTHING                = 0;
constant CURL_GLOBAL_DEFAULT                = CURL_GLOBAL_ALL;
constant CURL_GLOBAL_ACK_EINTR              = 1 +< 2;

constant CURL_SOCKET_BAD                    = -1;

constant CURLINFO_STRING                    = 0x100000;
constant CURLINFO_LONG                      = 0x200000;
constant CURLINFO_DOUBLE                    = 0x300000;
constant CURLINFO_SLIST                     = 0x400000;
constant CURLINFO_SOCKET                    = 0x500000;

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
constant CURLINFO_ACTIVESOCKET              = CURLINFO_SOCKET + 44;

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
constant CURLOPT_SSL_ENABLE_NPN             = CURLOPTTYPE_LONG          + 225;
constant CURLOPT_SSL_ENABLE_ALPN            = CURLOPTTYPE_LONG          + 226;
constant CURLOPT_EXPECT_100_TIMEOUT_MS      = CURLOPTTYPE_LONG          + 227;
constant CURLOPT_PROXYHEADER                = CURLOPTTYPE_OBJECTPOINT   + 228;
constant CURLOPT_HEADEROPT                  = CURLOPTTYPE_LONG          + 229;
constant CURLOPT_PINNEDPUBLICKEY            = CURLOPTTYPE_OBJECTPOINT   + 230;
constant CURLOPT_UNIX_SOCKET_PATH           = CURLOPTTYPE_OBJECTPOINT   + 231;
constant CURLOPT_SSL_VERIFYSTATUS           = CURLOPTTYPE_LONG          + 232;
constant CURLOPT_SSL_FALSESTART             = CURLOPTTYPE_LONG          + 233;
constant CURLOPT_PATH_AS_IS                 = CURLOPTTYPE_LONG          + 234;
constant CURLOPT_PROXY_SERVICE_NAME         = CURLOPTTYPE_OBJECTPOINT   + 235;
constant CURLOPT_SERVICE_NAME               = CURLOPTTYPE_OBJECTPOINT   + 236;
constant CURLOPT_PIPEWAIT                   = CURLOPTTYPE_LONG          + 237;
constant CURLOPT_DEFAULT_PROTOCOL           = CURLOPTTYPE_OBJECTPOINT   + 238;
constant CURLOPT_STREAM_WEIGHT              = CURLOPTTYPE_LONG          + 239;
constant CURLOPT_STREAM_DEPENDS             = CURLOPTTYPE_OBJECTPOINT   + 240;
constant CURLOPT_STREAM_DEPENDS_E           = CURLOPTTYPE_OBJECTPOINT   + 241;
constant CURLOPT_PROXY_SSL_VERIFYPEER       = CURLOPTTYPE_LONG          + 248;
constant CURLOPT_PROXY_SSL_VERIFYHOST       = CURLOPTTYPE_LONG          + 249;
constant CURLOPT_REQUEST_TARGET             = CURLOPTTYPE_OBJECTPOINT   + 266;
constant CURLOPT_SOCKS5_AUTH                = CURLOPTTYPE_LONG          + 267;
constant CURLOPT_SSH_COMPRESSION            = CURLOPTTYPE_LONG          + 268;
constant CURLOPT_MIMEPOST                   = CURLOPTTYPE_OBJECTPOINT   + 269;

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

enum CURLform <
    CURLFORM_NOTHING
    CURLFORM_COPYNAME
    CURLFORM_PTRNAME
    CURLFORM_NAMELENGTH
    CURLFORM_COPYCONTENTS
    CURLFORM_PTRCONTENTS
    CURLFORM_CONTENTSLENGTH
    CURLFORM_FILECONTENT
    CURLFORM_ARRAY
    CURLFORM_OBSOLETE
    CURLFORM_FILE
    CURLFORM_BUFFER
    CURLFORM_BUFFERPTR
    CURLFORM_BUFFERLENGTH
    CURLFORM_CONTENTTYPE
    CURLFORM_CONTENTHEADER
    CURLFORM_FILENAME
    CURLFORM_END
    CURLFORM_OBSOLETE2
    CURLFORM_STREAM>;

enum CURLFORMcode <
    CURL_FORMADD_OK
    CURL_FORMADD_MEMORY
    CURL_FORMADD_OPTION_TWICE
    CURL_FORMADD_NULL
    CURL_FORMADD_UNKNOWN_OPTION
    CURL_FORMADD_INCOMPLETE
    CURL_FORMADD_ILLEGAL_ARRAY
    CURL_FORMADD_DISABLED
>;

sub curl_global_init(long) returns uint32 is native(LIBCURL) is export { * }

sub curl_global_cleanup() is native(LIBCURL) is export { * }

sub curl_version() returns Str is native(LIBCURL) is export { * }

sub curl_free(Pointer $ptr) is native(LIBCURL) is export { * }

class X::LibCurl is Exception
{
    has Int $.code;

    sub curl_easy_strerror(uint32) returns Str is native(LIBCURL) { * }

    method Int() { $!code }

    method message() { curl_easy_strerror($!code) }
}

class timeval is repr('CStruct')
{
    has longlong $.tv_sec;
    has longlong $.tv_usec;

    submethod BUILD(Int :$tv)
    {
        $!tv_sec = Int($tv / 1000);
        $!tv_usec = $tv % 1000;
    }
}

sub select(int32, Blob, Blob, Blob, timeval --> int32) is native {}

sub wait_on_socket(uint32 $sockfd, :$timeout = 60000,
                   Bool :$recv) is export
{
    my timeval $tv .= new(:tv($timeout));
    my $fd-set-size = Int($sockfd/8) + 2;
    my $infd = buf8.allocate($fd-set-size);
    my $outfd = buf8.allocate($fd-set-size);
    my $errfd = buf8.allocate($fd-set-size);

    $errfd[$sockfd / 8] +|= 1 +< ($sockfd % 8);
    if $recv
    {
        $infd[$sockfd / 8] +|= 1 +< ($sockfd % 8);
    }
    else
    {
        $outfd[$sockfd / 8] +|= 1 +< ($sockfd % 8);
    }

    select($sockfd+1, $infd, $outfd, $errfd, $tv)
}

class X::LibCurl::Form is X::LibCurl
{
    method message() { ... }
}

class LibCurl::mime is repr('CPointer') { ... }

class LibCurl::mimepart is repr('CPointer')                     # curl_mimepart
{
    multi method data(Blob, size_t --> int32)
        is native(LIBCURL) is symbol('curl_mime_data') { * }

    multi method data(Blob:D $blob)
    {
        my size_t $size = $blob.bytes;
        samewith $blob, $size
    }

    multi method data(Str:D $str)
    {
        samewith $str.encode
    }

    multi method data(Any:D $obj)
    {
        samewith ~$obj
    }

    method filedata(Str --> int32)
        is native(LIBCURL) is symbol('curl_mime_filedata') { * }

    method filename(Str --> int32)
        is native(LIBCURL) is symbol('curl_mime_filename') { * }

    method name(Str --> int32)
        is native(LIBCURL) is symbol('curl_mime_name') { * }

    method type(Str --> int32)
        is native(LIBCURL) is symbol('curl_mime_type') { * }

    method subparts(LibCurl::mime --> int32)
        is native(LIBCURL) is symbol('curl_mime_subparts') { * }
}

class LibCurl::mime                                              # curl_mime
{
    method addpart(--> LibCurl::mimepart)
        is native(LIBCURL) is symbol('curl_mime_addpart') { * }

    method free()
        is native(LIBCURL) is symbol('curl_mime_free') { * }

    submethod DESTROY() { self.free }
}


class LibCurl::slist-struct is repr('CStruct')
{
    has Str $.data;
    has Pointer $.next;
}

class LibCurl::slist is repr('CPointer')
{
    sub curl_slist_append(LibCurl::slist, Str) returns LibCurl::slist
        is native(LIBCURL) { * }

    sub curl_slist_free_all(LibCurl::slist) is native(LIBCURL) { * }

    method append(*@str-list) returns LibCurl::slist
    {
        my $slist = self;
        $slist = curl_slist_append($slist, $_) for @str-list;
        return $slist;
    }

    method list() returns Array
    {
        my @list;
        my $slist = nativecast(LibCurl::slist-struct, self);
        while $slist
        {
            @list.push($slist.data);
            $slist = nativecast(LibCurl::slist-struct, $slist.next);
        }
        return @list;
    }

    method free()
    {
        curl_slist_free_all(self);
    }
}

class LibCurl::certinfo is repr('CStruct')
{
    has int32 $.num_of_certs;
    has CArray[LibCurl::slist] $.certinfo;
}

class LibCurl::version-info is repr('CStruct')
{
    has uint32      $.age;
    has Str         $.version;
    has uint32      $.version-num;
    has Str         $.host;
    has int32       $.features-code;
    has Str         $.ssl-version;
    has long        $.ssl-version-num;
    has Str         $.libz-version;
    has CArray[Str] $!protocols;
    has Str         $.ares;
    has int32       $.ares-num;
    has Str         $.libidn;
    has int32       $.iconv-ver-num;
    has Str         $.libssh-version;

    method features
    {
        state $feature-set = CURL_VERSION_FEATURE.enums
                             .grep({$!features-code +& $_.value})
                             .map({ $_.key ~~ /^CURL_VERSION_(.*)$/; ~$0 })
                             .Set;
    }

    method protocols
    {
        state $protocol-set = set gather {
            loop (my $i = 0; $!protocols[$i]; $i++)
            {
                take $!protocols[$i];
            }
        };
    }

    method check(Str:D $version--> Bool:D)
    {
        my $major = $!version-num +> 16;
        my $minor = $!version-num +> 8 +& 0xff;
        my $patch = $!version-num +& 0xff;
        my @parts = $version.split('.');
        return not ($major < (@parts[0])
                 || $minor < (@parts[1] // 0)
                 || $patch < (@parts[2] // 0))
    }
}

class LibCurl::version is repr('CPointer')
{
    sub curl_version_info(uint32 $type) returns LibCurl::version
        is native(LIBCURL) { * }

    method new() { curl_version_info(CURLVERSION_NOW) }

    method info() { nativecast(LibCurl::version-info, self) }
}

class LibCurl::EasyHandle is repr('CPointer')
{
    sub curl_easy_init() returns LibCurl::EasyHandle is native(LIBCURL) { * }

    sub curl_easy_cleanup(LibCurl::EasyHandle) is native(LIBCURL) { * }

    sub curl_easy_reset(LibCurl::EasyHandle) is native(LIBCURL) { * }

    sub curl_easy_duphandle(LibCurl::EasyHandle) returns LibCurl::EasyHandle
        is native(LIBCURL) { * }

    sub curl_easy_escape(LibCurl::EasyHandle, Buf, int32) returns Pointer
        is native(LIBCURL) { * }

    sub curl_easy_unescape(LibCurl::EasyHandle, Buf, int32, int32 is rw)
        returns Pointer is native(LIBCURL) { * }

    sub curl_easy_setopt_str(LibCurl::EasyHandle, uint32, Str) returns uint32
        is native(LIBCURL) is symbol('curl_easy_setopt') { * }

    sub curl_easy_setopt_long(LibCurl::EasyHandle, uint32, long) returns uint32
        is native(LIBCURL) is symbol('curl_easy_setopt') { * }

    sub curl_easy_setopt_ptr(LibCurl::EasyHandle, uint32, Pointer)
        returns uint32 is native(LIBCURL) is symbol('curl_easy_setopt') { * }

    sub curl_easy_setopt_slist(LibCurl::EasyHandle, uint32, LibCurl::slist)
        returns uint32 is native(LIBCURL) is symbol('curl_easy_setopt') { * }

    sub curl_easy_setopt_array(LibCurl::EasyHandle, uint32, CArray[uint8])
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

    sub curl_easy_getinfo_ptr(LibCurl::EasyHandle, int32, CArray[Pointer])
        returns uint32 is native(LIBCURL) is symbol('curl_easy_getinfo') { * }

    sub curl_easy_getinfo_socket(LibCurl::EasyHandle, int32, int32 is rw)
        returns uint32 is native(LIBCURL) is symbol('curl_easy_getinfo') { * }

    sub curl_easy_send(LibCurl::EasyHandle, Blob, size_t, size_t is rw
        --> uint32) is native(LIBCURL) {}

    sub curl_easy_recv(LibCurl::EasyHandle, Blob, size_t, size_t is rw
        --> uint32) is native(LIBCURL) {}

    method new() returns LibCurl::EasyHandle { curl_easy_init }

    method id() returns Int {
        return +nativecast(Pointer, self);
    }

    method cleanup() { curl_easy_cleanup(self) }

    method reset() { curl_easy_reset(self) }

    method duphandle() { curl_easy_duphandle(self) }

    method escape(Str $str, $encoding = 'utf-8')
    {
        my $buf = $str.encode($encoding);
        my $ptr = curl_easy_escape(self, $buf, $buf.elems);
        my $esc = nativecast(Str, $ptr);
        curl_free($ptr);
        return $esc;
    }

    method unescape(Str $str, $encoding = 'utf-8')
    {
        my $buf = $str.encode($encoding);
        my int32 $outlength;
        my $ptr = curl_easy_unescape(self, $buf, $buf.elems, $outlength);
        my $arr = nativecast(CArray[int8], $ptr);
        my $outstr = Buf.new($arr[0 ..^ $outlength]).decode($encoding);
        curl_free($ptr);
        return $outstr;
    }

    method perform() { curl_easy_perform(self); }

    multi method setopt($option, Str $param) {
        my $ret = curl_easy_setopt_str(self, $option, $param);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
    }

    multi method setopt($option, Int $param) {
        my $ret = curl_easy_setopt_long(self, $option, $param);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
    }

    multi method setopt($option, &callback) {
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
    }

    multi method setopt($option, Pointer $ptr) {
        my $ret = curl_easy_setopt_ptr(self, $option, $ptr);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
    }

    multi method setopt($option, LibCurl::slist $slist) {
        my $ret = curl_easy_setopt_slist(self, $option, $slist);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
    }

    multi method setopt($option, CArray[uint8] $ptr) {
        my $ret = curl_easy_setopt_array(self, $option, $ptr);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
    }

    multi method setopt($option, LibCurl::EasyHandle $ptr) {
        my $ret = curl_easy_setopt_ptr(self, $option, $ptr);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
    }

    multi method setopt($option, LibCurl::mime $ptr) {
        my $ret = curl_easy_setopt_ptr(self, $option, $ptr);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
    }

    method getinfo_long($option) returns long {
        my long $value;
        my $ret = curl_easy_getinfo_long(self, $option, $value);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return $value;
    }

    method getinfo_socket($option) returns int32 {
        my int32 $sock;
        my $ret = curl_easy_getinfo_socket(self, $option, $sock);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return $sock;
    }

    method getinfo_double($option) {
        my num64 $value;
        my $ret = curl_easy_getinfo_double(self, $option, $value);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return $value[0];
    }

    method getinfo_str($option) {
        my $value = CArray[Str].new;
        $value[0] = '';
        my $ret = curl_easy_getinfo_str(self, $option, $value);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return $value[0];
    }

    method getinfo_slist($option) {
        my $value = CArray[Pointer].new;
        $value[0] = Pointer.new;
        my $ret = curl_easy_getinfo_ptr(self, $option, $value);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return [] unless $value[0];
        my $slist = nativecast(LibCurl::slist, $$value[0]);
        my @list = $slist.list;
        $slist.free;
        return @list;
    }

    method mime-init(--> LibCurl::mime)
        is native(LIBCURL) is symbol('curl_mime_init') { * }

    method getinfo_certinfo() {
	... # TODO
        my Pointer $ptr;
        my $ret = curl_easy_getinfo_ptr(self, CURLINFO_CERTINFO, $ptr);
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK;
        return nativecast(LibCurl::certinfo, $ptr);
    }

    multi method send(Str $str) { $.send($str.encode) }

    multi method send(Blob $buf, :$timeout = 60000) {
        my $sockfd = $.getinfo_socket(CURLINFO_ACTIVESOCKET);
        return False if $sockfd  == CURL_SOCKET_BAD;
        my size_t $tosend = $buf.elems;
        my size_t $sent;
        my $ret;
        repeat
        {
            $ret = curl_easy_send(self,
                                  $buf.subbuf($buf.elems-$tosend),
                                  $tosend, $sent);
            $tosend -= $sent;
            if $ret == CURLE_AGAIN
                && wait_on_socket($sockfd, :$timeout) == 0
            {
                die "Timeout";
            }
        } while $ret == CURLE_AGAIN && $tosend > 0;
        die X::LibCurl.new(code => $ret) unless $ret == CURLE_OK
    }

    method recv(:$bufsiz = 8192, :$timeout = 60000) {
        my $sockfd = $.getinfo_socket(CURLINFO_ACTIVESOCKET);
        return if $sockfd  == CURL_SOCKET_BAD;
        my $buf = buf8.allocate($bufsiz);
        my size_t $nread;
        my $ret;
        repeat
        {
            $ret = curl_easy_recv(self, $buf, $bufsiz, $nread);
            if $ret == CURLE_AGAIN &&
                wait_on_socket($sockfd, :recv, :$timeout) == 0
            {
                die "Timeout";
            }
        } while $ret == CURLE_AGAIN;
        $ret == CURLE_OK ?? $buf.subbuf(^$nread) !! False
    }
}
