use v6;

use NativeCall;

constant LIBCURL = "curl";

constant CURLOPT_URL                           = 10002;
constant CURLE_OK                              = 0;

constant CURL_ERROR_SIZE                       = 256;

constant CURL_NETRC_IGNORED                    = 0;
constant CURL_NETRC_OPTIONAL                   = 1;
constant CURL_NETRC_REQUIRED                   = 2;

constant CURLPROXY_HTTP                        = 0;
constant CURLPROXY_HTTP_1_0                    = 1;
constant CURLPROXY_SOCKS4                      = 4;
constant CURLPROXY_SOCKS5                      = 5;
constant CURLPROXY_SOCKS4A                     = 6;
constant CURLPROXY_SOCKS5_HOSTNAME             = 7;

constant CURLUSESSL_NONE                       = 0;
constant CURLUSESSL_TRY                        = 1;
constant CURLUSESSL_CONTROL                    = 2;
constant CURLUSESSL_ALL                        = 3;

constant CURLINFO_TEXT                         = 0;
constant CURLINFO_HEADER_IN                    = 1;
constant CURLINFO_HEADER_OUT                   = 2;
constant CURLINFO_DATA_IN                      = 3;
constant CURLINFO_DATA_OUT                     = 4;
constant CURLINFO_SSL_DATA_IN                  = 5;
constant CURLINFO_SSL_DATA_OUT                 = 6;

constant CURLINFO_STRING                       = 0x100000;
constant CURLINFO_LONG                         = 0x200000;
constant CURLINFO_DOUBLE                       = 0x300000;
constant CURLINFO_SLIST                        = 0x400000;

constant CURLINFO_EFFECTIVE_URL                = CURLINFO_STRING + 1;
constant CURLINFO_RESPONSE_CODE                = CURLINFO_LONG   + 2;
constant CURLINFO_TOTAL_TIME                   = CURLINFO_DOUBLE + 3;
constant CURLINFO_NAMELOOKUP_TIME              = CURLINFO_DOUBLE + 4;
constant CURLINFO_CONNECT_TIME                 = CURLINFO_DOUBLE + 5;
constant CURLINFO_PRETRANSFER_TIME             = CURLINFO_DOUBLE + 6;
constant CURLINFO_SIZE_UPLOAD                  = CURLINFO_DOUBLE + 7;
constant CURLINFO_SIZE_DOWNLOAD                = CURLINFO_DOUBLE + 8;
constant CURLINFO_SPEED_DOWNLOAD               = CURLINFO_DOUBLE + 9;
constant CURLINFO_SPEED_UPLOAD                 = CURLINFO_DOUBLE + 10;
constant CURLINFO_HEADER_SIZE                  = CURLINFO_LONG   + 11;
constant CURLINFO_REQUEST_SIZE                 = CURLINFO_LONG   + 12;
constant CURLINFO_SSL_VERIFYRESULT             = CURLINFO_LONG   + 13;
constant CURLINFO_FILETIME                     = CURLINFO_LONG   + 14;
constant CURLINFO_CONTENT_LENGTH_DOWNLOAD      = CURLINFO_DOUBLE + 15;
constant CURLINFO_CONTENT_LENGTH_UPLOAD        = CURLINFO_DOUBLE + 16;
constant CURLINFO_STARTTRANSFER_TIME           = CURLINFO_DOUBLE + 17;
constant CURLINFO_CONTENT_TYPE                 = CURLINFO_STRING + 18;
constant CURLINFO_REDIRECT_TIME                = CURLINFO_DOUBLE + 19;
constant CURLINFO_REDIRECT_COUNT               = CURLINFO_LONG   + 20;
constant CURLINFO_PRIVATE                      = CURLINFO_STRING + 21;
constant CURLINFO_HTTP_CONNECTCODE             = CURLINFO_LONG   + 22;
constant CURLINFO_HTTPAUTH_AVAIL               = CURLINFO_LONG   + 23;
constant CURLINFO_PROXYAUTH_AVAIL              = CURLINFO_LONG   + 24;
constant CURLINFO_OS_ERRNO                     = CURLINFO_LONG   + 25;
constant CURLINFO_NUM_CONNECTS                 = CURLINFO_LONG   + 26;
constant CURLINFO_SSL_ENGINES                  = CURLINFO_SLIST  + 27;
constant CURLINFO_COOKIELIST                   = CURLINFO_SLIST  + 28;
constant CURLINFO_LASTSOCKET                   = CURLINFO_LONG   + 29;
constant CURLINFO_FTP_ENTRY_PATH               = CURLINFO_STRING + 30;
constant CURLINFO_REDIRECT_URL                 = CURLINFO_STRING + 31;
constant CURLINFO_PRIMARY_IP                   = CURLINFO_STRING + 32;
constant CURLINFO_APPCONNECT_TIME              = CURLINFO_DOUBLE + 33;
constant CURLINFO_CERTINFO                     = CURLINFO_SLIST  + 34;
constant CURLINFO_CONDITION_UNMET              = CURLINFO_LONG   + 35;
constant CURLINFO_RTSP_SESSION_ID              = CURLINFO_STRING + 36;
constant CURLINFO_RTSP_CLIENT_CSEQ             = CURLINFO_LONG   + 37;
constant CURLINFO_RTSP_SERVER_CSEQ             = CURLINFO_LONG   + 38;
constant CURLINFO_RTSP_CSEQ_RECV               = CURLINFO_LONG   + 39;
constant CURLINFO_PRIMARY_PORT                 = CURLINFO_LONG   + 40;
constant CURLINFO_LOCAL_IP                     = CURLINFO_STRING + 41;
constant CURLINFO_LOCAL_PORT                   = CURLINFO_LONG   + 42;
constant CURLINFO_TLS_SESSION                  = CURLINFO_SLIST  + 43;

constant CURL_GLOBAL_DEFAULT                   = 0x3;
constant CURLOPT_FILE                          = 10001;
constant CURLOPT_WRITEDATA                     = 10001;
constant CURLOPT_PORT                          = 3;
constant CURLOPT_PROXY                         = 10004;
constant CURLOPT_USERPWD                       = 10005;
constant CURLOPT_PROXYUSERPWD                  = 10006;
constant CURLOPT_RANGE                         = 10007;
constant CURLOPT_INFILE                        = 10009;
constant CURLOPT_READDATA                      = 10009;
constant CURLOPT_ERRORBUFFER                   = 10010;
constant CURLOPT_WRITEFUNCTION                 = 20011;
constant CURLOPT_READFUNCTION                  = 20012;
constant CURLOPT_TIMEOUT                       = 13;
constant CURLOPT_INFILESIZE                    = 14;
constant CURLOPT_POSTFIELDS                    = 10015;
constant CURLOPT_REFERER                       = 10016;
constant CURLOPT_FTPPORT                       = 10017;
constant CURLOPT_USERAGENT                     = 10018;
constant CURLOPT_LOW_SPEED_LIMIT               = 19;
constant CURLOPT_LOW_SPEED_TIME                = 20;
constant CURLOPT_RESUME_FROM                   = 21;
constant CURLOPT_COOKIE                        = 10022;
constant CURLOPT_HTTPHEADER                    = 10023;
constant CURLOPT_HTTPPOST                      = 10024;
constant CURLOPT_SSLCERT                       = 10025;
constant CURLOPT_KEYPASSWD                     = 10026;
constant CURLOPT_CRLF                          = 27;
constant CURLOPT_QUOTE                         = 10028;
constant CURLOPT_WRITEHEADER                   = 10029;
constant CURLOPT_HEADERDATA                    = 10029;
constant CURLOPT_COOKIEFILE                    = 10031;
constant CURLOPT_SSLVERSION                    = 32;
constant CURLOPT_TIMECONDITION                 = 33;
constant CURLOPT_TIMEVALUE                     = 34;
constant CURLOPT_CUSTOMREQUEST                 = 10036;
constant CURLOPT_STDERR                        = 10037;
constant CURLOPT_POSTQUOTE                     = 10039;
constant CURLOPT_WRITEINFO                     = 10040;
constant CURLOPT_VERBOSE                       = 41;
constant CURLOPT_HEADER                        = 42;
constant CURLOPT_NOPROGRESS                    = 43;
constant CURLOPT_NOBODY                        = 44;
constant CURLOPT_FAILONERROR                   = 45;
constant CURLOPT_UPLOAD                        = 46;
constant CURLOPT_POST                          = 47;
constant CURLOPT_DIRLISTONLY                   = 48;
constant CURLOPT_APPEND                        = 50;
constant CURLOPT_NETRC                         = 51;
constant CURLOPT_FOLLOWLOCATION                = 52;
constant CURLOPT_TRANSFERTEXT                  = 53;
constant CURLOPT_PUT                           = 54;
constant CURLOPT_PROGRESSFUNCTION              = 20056;
constant CURLOPT_PROGRESSDATA                  = 10057;
constant CURLOPT_XFERINFODATA                  = 10057;
constant CURLOPT_AUTOREFERER                   = 58;
constant CURLOPT_PROXYPORT                     = 59;
constant CURLOPT_POSTFIELDSIZE                 = 60;
constant CURLOPT_HTTPPROXYTUNNEL               = 61;
constant CURLOPT_INTERFACE                     = 10062;
constant CURLOPT_KRBLEVEL                      = 10063;
constant CURLOPT_SSL_VERIFYPEER                = 64;
constant CURLOPT_SSL_VERIFYHOST                = 81;
constant CURLOPT_CAINFO                        = 10065;
constant CURLOPT_MAXREDIRS                     = 68;
constant CURLOPT_FILETIME                      = 69;
constant CURLOPT_TELNETOPTIONS                 = 10070;
constant CURLOPT_MAXCONNECTS                   = 71;
constant CURLOPT_CLOSEPOLICY                   = 72;
constant CURLOPT_FRESH_CONNECT                 = 74;
constant CURLOPT_FORBID_REUSE                  = 75;
constant CURLOPT_RANDOM_FILE                   = 10076;
constant CURLOPT_EGDSOCKET                     = 10077;
constant CURLOPT_CONNECTTIMEOUT                = 78;
constant CURLOPT_HEADERFUNCTION                = 20079;
constant CURLOPT_HTTPGET                       = 80;
constant CURLOPT_COOKIEJAR                     = 10082;
constant CURLOPT_SSL_CIPHER_LIST               = 10083;
constant CURLOPT_HTTP_VERSION                  = 84;
constant CURLOPT_FTP_USE_EPSV                  = 85;
constant CURLOPT_SSLCERTTYPE                   = 10086;
constant CURLOPT_SSLKEY                        = 10087;
constant CURLOPT_SSLKEYTYPE                    = 10088;
constant CURLOPT_SSLENGINE                     = 10089;
constant CURLOPT_SSLENGINE_DEFAULT             = 90;
constant CURLOPT_DNS_USE_GLOBAL_CACHE          = 91;
constant CURLOPT_DNS_CACHE_TIMEOUT             = 92;
constant CURLOPT_PREQUOTE                      = 10093;
constant CURLOPT_DEBUGFUNCTION                 = 20094;
constant CURLOPT_DEBUGDATA                     = 10095;
constant CURLOPT_COOKIESESSION                 = 96;
constant CURLOPT_CAPATH                        = 10097;
constant CURLOPT_BUFFERSIZE                    = 98;
constant CURLOPT_NOSIGNAL                      = 99;
constant CURLOPT_SHARE                         = 10100;
constant CURLOPT_PROXYTYPE                     = 101;
constant CURLOPT_ACCEPT_ENCODING               = 10102;
constant CURLOPT_PRIVATE                       = 10103;
constant CURLOPT_HTTP200ALIASES                = 10104;
constant CURLOPT_UNRESTRICTED_AUTH             = 105;
constant CURLOPT_FTP_USE_EPRT                  = 106;
constant CURLOPT_HTTPAUTH                      = 107;
constant CURLOPT_SSL_CTX_FUNCTION              = 20108;
constant CURLOPT_SSL_CTX_DATA                  = 10109;
constant CURLOPT_PROXYAUTH                     = 111;
constant CURLOPT_FTP_RESPONSE_TIMEOUT          = 112;
constant CURLOPT_IPRESOLVE                     = 113;
constant CURLOPT_MAXFILESIZE                   = 114;
constant CURLOPT_INFILESIZE_LARGE              = 30115;
constant CURLOPT_RESUME_FROM_LARGE             = 30116;
constant CURLOPT_MAXFILESIZE_LARGE             = 30117;
constant CURLOPT_NETRC_FILE                    = 10118;
constant CURLOPT_USE_SSL                       = 119;
constant CURLOPT_POSTFIELDSIZE_LARGE           = 30120;
constant CURLOPT_TCP_NODELAY                   = 121;
constant CURLOPT_FTPSSLAUTH                    = 129;
constant CURLOPT_IOCTLFUNCTION                 = 20130;
constant CURLOPT_IOCTLDATA                     = 10131;
constant CURLOPT_FTP_ACCOUNT                   = 10134;
constant CURLOPT_COOKIELIST                    = 10135;
constant CURLOPT_IGNORE_CONTENT_LENGTH         = 136;
constant CURLOPT_FTP_SKIP_PASV_IP              = 137;
constant CURLOPT_FTP_FILEMETHOD                = 138;
constant CURLOPT_LOCALPORT                     = 139;
constant CURLOPT_LOCALPORTRANGE                = 140;
constant CURLOPT_CONNECT_ONLY                  = 141;
constant CURLOPT_FTP_CREATE_MISSING_DIRS       = 110;
constant CURLOPT_CONV_FROM_NETWORK_FUNCTION    = 20142;
constant CURLOPT_CONV_TO_NETWORK_FUNCTION      = 20143;
constant CURLOPT_CONV_FROM_UTF8_FUNCTION       = 20144;
constant CURLOPT_MAX_SEND_SPEED_LARGE          = 30145;
constant CURLOPT_MAX_RECV_SPEED_LARGE          = 30146;
constant CURLOPT_FTP_ALTERNATIVE_TO_USER       = 10147;
constant CURLOPT_SSH_HOST_PUBLIC_KEY_MD5       = 10162;
constant CURLOPT_HTTP_TRANSFER_DECODING        = 157;
constant CURLOPT_SOCKOPTFUNCTION               = 20148;
constant CURLOPT_SOCKOPTDATA                   = 10149;
constant CURLOPT_SSL_SESSIONID_CACHE           = 150;
constant CURLOPT_SSH_AUTH_TYPES                = 151;
constant CURLOPT_SSH_PUBLIC_KEYFILE            = 10152;
constant CURLOPT_SSH_PRIVATE_KEYFILE           = 10153;
constant CURLOPT_FTP_SSL_CCC                   = 154;
constant CURLOPT_TIMEOUT_MS                    = 155;
constant CURLOPT_CONNECTTIMEOUT_MS             = 156;
constant CURLOPT_HTTP_CONTENT_DECODING         = 158;
constant CURLOPT_NEW_FILE_PERMS                = 159;
constant CURLOPT_NEW_DIRECTORY_PERMS           = 160;
constant CURLOPT_POSTREDIR                     = 161;
constant CURLOPT_OPENSOCKETFUNCTION            = 20163;
constant CURLOPT_OPENSOCKETDATA                = 10164;
constant CURLOPT_COPYPOSTFIELDS                = 10165;
constant CURLOPT_PROXY_TRANSFER_MODE           = 166;
constant CURLOPT_SEEKFUNCTION                  = 20167;
constant CURLOPT_SEEKDATA                      = 10168;
constant CURLOPT_CRLFILE                       = 10169;
constant CURLOPT_ISSUERCERT                    = 10170;
constant CURLOPT_ADDRESS_SCOPE                 = 171;
constant CURLOPT_CERTINFO                      = 172;
constant CURLOPT_USERNAME                      = 10173;
constant CURLOPT_PASSWORD                      = 10174;
constant CURLOPT_PROXYUSERNAME                 = 10175;
constant CURLOPT_PROXYPASSWORD                 = 10176;
constant CURLOPT_NOPROXY                       = 10177;
constant CURLOPT_TFTP_BLKSIZE                  = 178;
constant CURLOPT_SOCKS5_GSSAPI_SERVICE         = 10179;
constant CURLOPT_SOCKS5_GSSAPI_NEC             = 180;
constant CURLOPT_PROTOCOLS                     = 181;
constant CURLOPT_REDIR_PROTOCOLS               = 182;
constant CURLOPT_SSH_KNOWNHOSTS                = 10183;
constant CURLOPT_SSH_KEYFUNCTION               = 20184;
constant CURLOPT_SSH_KEYDATA                   = 10185;
constant CURLOPT_MAIL_FROM                     = 10186;
constant CURLOPT_MAIL_RCPT                     = 10187;
constant CURLOPT_FTP_USE_PRET                  = 188;
constant CURLOPT_RTSP_REQUEST                  = 189;
constant CURLOPT_RTSP_SESSION_ID               = 10190;
constant CURLOPT_RTSP_STREAM_URI               = 10191;
constant CURLOPT_RTSP_TRANSPORT                = 10192;
constant CURLOPT_RTSP_CLIENT_CSEQ              = 193;
constant CURLOPT_RTSP_SERVER_CSEQ              = 194;
constant CURLOPT_INTERLEAVEDATA                = 10195;
constant CURLOPT_INTERLEAVEFUNCTION            = 20196;
constant CURLOPT_WILDCARDMATCH                 = 197;
constant CURLOPT_CHUNK_BGN_FUNCTION            = 20198;
constant CURLOPT_CHUNK_END_FUNCTION            = 20199;
constant CURLOPT_FNMATCH_FUNCTION              = 20200;
constant CURLOPT_CHUNK_DATA                    = 10201;
constant CURLOPT_FNMATCH_DATA                  = 10202;
constant CURLOPT_RESOLVE                       = 10203;
constant CURLOPT_TLSAUTH_USERNAME              = 10204;
constant CURLOPT_TLSAUTH_PASSWORD              = 10205;
constant CURLOPT_TLSAUTH_TYPE                  = 10206;
constant CURLOPT_TRANSFER_ENCODING             = 207;
constant CURLOPT_CLOSESOCKETFUNCTION           = 20208;
constant CURLOPT_CLOSESOCKETDATA               = 10209;
constant CURLOPT_GSSAPI_DELEGATION             = 210;
constant CURLOPT_DNS_SERVERS                   = 10211;
constant CURLOPT_ACCEPTTIMEOUT_MS              = 212;
constant CURLOPT_TCP_KEEPALIVE                 = 213;
constant CURLOPT_TCP_KEEPIDLE                  = 214;
constant CURLOPT_TCP_KEEPINTVL                 = 215;
constant CURLOPT_SSL_OPTIONS                   = 216;
constant CURLOPT_MAIL_AUTH                     = 10217;
constant CURLOPT_XFERINFOFUNCTION              = 20219;

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
	   when CURLOPT_WRITEFUNCTION|CURLOPT_READFUNCTION|
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
