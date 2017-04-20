NAME
====

LibCurl::MultiHandle

SYNOPSIS
========

    use LibCurl::EasyHandle;
    use LibCurl::MultiHandle;

    curl_global_init(CURL_GLOBAL_DEFAULT);

    my $easy = LibCurl::EasyHandle.new;
    $easy.setopt(CURLOPT_URL, "http://example.com");

    my $multi = LibCurl::MultiHandle.new;

    $multi.setopt(CURLMOPT_MAXCONNECT, 1);

    $multi.add-handle($easy);

    my int32 $running-handles = 1;
    my int32 $numfds = 0;
    my $timeout-ms = 1000;

    repeat
    {
        $multi.perform($running-handles);
        $multi.wait($timeout-ms, $numfds);
        my int32 $msgs-in-queue = 0;
        while my $msg = $!multi.info($msgs-in-queue)
        {
            next unless $msg.msg == CURLMSG_DONE;

    my $easy = $msg.handle;
    $multi.remove-handle($easy);
    $easy.cleanup;

    }

    } while $running-handles;

    $multi.cleanup;

    curl_global_cleanup;

DESCRIPTION
===========

`LibCurl::MultiHandle` is the low level NativeCall interface to libcurl's [multi interface](https://curl.haxx.se/libcurl/c/libcurl-multi.html). In general you should be using the `LibCurl::Multi` interface instead.

CLASSES
=======

class **LibCurl::CURLMsg** is repr('CStruct')
---------------------------------------------

Wrapper for **struct CURLMsg**

  * has uint32 $.msg

  * has LibCurl::EasyHandle $.handle

  * has uint32 $.code

class **X::LibCurl::Multi** is X::LibCurl
-----------------------------------------

Exception, just like [X::LibCurl](X::LibCurl), but for **CURLMcode**.

  * method **message**() returns Str

Returns the Str version of the errror with [**curl_multi_strerror**](https://curl.haxx.se/libcurl/c/curl_multi_strerror.html).

### class **LibCurl::MultiHandle** is repr('CPointer')

Wrapper for pointer to a **struct CURLM**.

  * method **new**() returns LibCurl::MultiHandle

Wrapper for [**curl_multi_init**](https://curl.haxx.se/libcurl/c/curl_multi_init.html).

  * method **cleanup**()

Wrapper for [**curl_multi_cleanup**](https://curl.haxx.se/libcurl/c/curl_multi_cleanup.html).

  * method **add-handle**(LibCurl::EasyHandle $handle)

Wrapper for [**curl_multi_add_handle**](https://curl.haxx.se/libcurl/c/curl_multi_add_handle.html).

  * method **remove-handle**(LibCurl::EasyHandle $handle)

Wrapper for [**curl_multi_remove_handle**](https://curl.haxx.se/libcurl/c/curl_multi_remove_handle.html).

  * multi method **setopt**($option, long $param)

Wrapper for [**curl_multi_setopt**](https://curl.haxx.se/libcurl/c/curl_multi_setopt.html).

  * method **perform**(int32 $running-handles is rw)

Wrapper for [**curl_multi_perform**](https://curl.haxx.se/libcurl/c/curl_multi_perform.html).

If **CURLM_CALL_MULTI_PERFORM** is returned, perform is immediately called again.

  * method **wait**(int32 $timeout-ms, int32 $numfds is rw)

Wrapper for [**curl_multi_wait**](https://curl.haxx.se/libcurl/c/curl_multi_wait.html).

  * method **info**(int32 $msgs-in-queue is rw) returns LibCurl::CURLMsg

Wrapper for [**curl_multi_info_read**](https://curl.haxx.se/libcurl/c/curl_multi_info_read.html).
