use v6;

use NativeCall;
use LibCurl::EasyHandle;

constant CURLM_CALL_MULTI_PERFORM  = -1;
constant CURLM_OK                  = 0; 
constant CURLM_BAD_HANDLE          = 1;
constant CURLM_BAD_EASY_HANDLE     = 2;
constant CURLM_OUT_OF_MEMORY       = 3;
constant CURLM_INTERNAL_ERROR      = 4;
constant CURLM_BAD_SOCKET          = 5;
constant CURLM_UNKNOWN_OPTION      = 6;
constant CURLM_ADDED_ALREADY       = 7;

constant CURLMSG_DONE              = 1;

constant CURLPIPE_NOTHING          = 0;
constant CURLPIPE_HTTP1            = 1;
constant CURLPIPE_MULTIPLEX        = 2;

constant CURLMOPT_SOCKETFUNCTION                = CURLOPTTYPE_FUNCTIONPOINT + 1;
constant CURLMOPT_SOCKETDATA                    = CURLOPTTYPE_OBJECTPOINT + 2;
constant CURLMOPT_PIPELINING                    = CURLOPTTYPE_LONG + 3;
constant CURLMOPT_TIMERFUNCTION                 = CURLOPTTYPE_FUNCTIONPOINT + 4;
constant CURLMOPT_TIMERDATA                     = CURLOPTTYPE_OBJECTPOINT + 5;
constant CURLMOPT_MAXCONNECTS                   = CURLOPTTYPE_LONG + 6;
constant CURLMOPT_MAX_HOST_CONNECTIONS          = CURLOPTTYPE_LONG + 7;
constant CURLMOPT_MAX_PIPELINE_LENGTH           = CURLOPTTYPE_LONG + 8;
constant CURLMOPT_CONTENT_LENGTH_PENALTY_SIZE   = CURLOPTTYPE_OFF_T + 9;
constant CURLMOPT_CHUNK_LENGTH_PENALTY_SIZE     = CURLOPTTYPE_OFF_T + 10;
constant CURLMOPT_PIPELINING_SITE_BL            = CURLOPTTYPE_OBJECTPOINT + 11;
constant CURLMOPT_PIPELINING_SERVER_BL          = CURLOPTTYPE_OBJECTPOINT + 12;
constant CURLMOPT_MAX_TOTAL_CONNECTIONS         = CURLOPTTYPE_LONG + 13;

class LibCurl::CURLMsg is repr('CStruct')
{
    has uint32 $.msg;
    has LibCurl::EasyHandle $.handle;
    has uint32 $.code;
}

class X::LibCurl::Multi is X::LibCurl
{
    sub curl_multi_strerror(uint32) returns Str is native(LIBCURL) { * }

    method message() { curl_multi_strerror(self.Int) }
}

class LibCurl::MultiHandle is repr('CPointer')
{
    sub curl_multi_init() returns LibCurl::MultiHandle is native(LIBCURL) { * }

    sub curl_multi_add_handle(LibCurl::MultiHandle, LibCurl::EasyHandle)
        returns uint32 is native(LIBCURL) { * }

    sub curl_multi_remove_handle(LibCurl::MultiHandle, LibCurl::EasyHandle)
        returns uint32 is native(LIBCURL) { * }

    sub curl_multi_setopt_long(LibCurl::MultiHandle, uint32, long)
        returns uint32 is native(LIBCURL) is symbol('curl_multi_setopt') { * }

    sub curl_multi_setopt_str(LibCurl::MultiHandle, uint32, Str)
        returns uint32 is native(LIBCURL) is symbol('curl_multi_setopt') { * }

    sub curl_multi_cleanup(LibCurl::MultiHandle) returns uint32
        is native(LIBCURL) { * }

    sub curl_multi_wait(LibCurl::MultiHandle,Pointer,uint32,int32,int32 is rw)
        returns uint32 is native(LIBCURL) { * }

    sub curl_multi_perform(LibCurl::MultiHandle, int32 is rw) returns uint32
        is native(LIBCURL) { * }

    sub curl_multi_info_read(LibCurl::MultiHandle, uint32 is rw)
        returns LibCurl::CURLMsg is native(LIBCURL) { * }

    method new() { curl_multi_init }

    method cleanup { curl_multi_cleanup(self) }

    method add-handle(LibCurl::EasyHandle $handle)
    {
        my $ret = curl_multi_add_handle(self, $handle);
        die X::LibCurl::Multi.new(code => $ret) unless $ret == CURLM_OK;
    }

    method remove-handle(LibCurl::EasyHandle $handle)
    {
        my $ret = curl_multi_remove_handle(self, $handle);
        die X::LibCurl::Multi.new(code => $ret) unless $ret == CURLM_OK;
    }

    multi method setopt($option, long $param)
    {
        my $ret = curl_multi_setopt_long(self, $option, $param);
        die X::LibCurl::Multi.new(code => $ret) unless $ret == CURLM_OK;
    }

    multi method setopt($option, Str $param)
    {
        my $ret = curl_multi_setopt_str(self, $option, $param);
        die X::LibCurl::Multi.new(code => $ret) unless $ret == CURLM_OK;
    }

    method perform(int32 $running-handles is rw)
    {
        loop
        {
            my $ret = curl_multi_perform(self, $running-handles);
            return CURLM_OK if $ret == CURLM_OK;
            next if $ret == CURLM_CALL_MULTI_PERFORM;
            die X::LibCurl::Multi.new(code => $ret);
        }
    }

    method wait(int32 $timeout-ms, int32 $numfds is rw)
    {
        my $ret = curl_multi_wait(self, Pointer, 0, $timeout-ms, $numfds);
        die X::LibCurl::Multi.new(code => $ret) unless $ret == CURLM_OK;
    }

    method info(int32 $msgs-in-queue is rw) returns LibCurl::CURLMsg
    {
        curl_multi_info_read(self, $msgs-in-queue);
    }
}
