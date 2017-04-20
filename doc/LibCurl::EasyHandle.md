NAME
====

LibCurl::EasyHandle

SYNOPSIS
========

    use LibCurl::EasyHandle;

    curl_global_init(CURL_GLOBAL_DEFAULT);

    say curl_version;

    my $handle = LibCurl::EasyHandle.new;

    $handle.setopt(CURLOPT_URL, "http://example.com");

    $handle.perform;

    say $handle.getinfo(CURL_GETINFO_RESPONSE_CODE);

    $handle.cleanup;

    curl_global_cleanup;

DESCRIPTION
===========

**LibCurl::EasyHandle** is the low level NativeCall interface to libcurl's [easy interface](https://curl.haxx.se/libcurl/c/libcurl-easy.html). In general you should be using the **LibCurl::Easy** interface instead.

SUBROUTINES
-----------

  * sub **curl_global_init**(long $flags) returns uint32

Nativecall version of [**curl_global_init**](https://curl.haxx.se/libcurl/c/curl_global_init.html). It can take the following *$flags*: CURL_GLOBAL_SSL, CURL_GLOBAL_WIN32, CURL_GLOBAL_ALL, CURL_GLOBAL_NOTHING, CURL_GLOBAL_DEFAULT, CURL_GLOBAL_ACK_EINTR.

  * sub **curl_global_cleanup**()

Nativecall version of [**curl_global_cleanup**](https://curl.haxx.se/libcurl/c/curl_global_cleanup.html).

  * sub **curl_version**() returns Str

Nativecall version of [**curl_version**](https://curl.haxx.se/libcurl/c/curl_version.html).

CLASSES
-------

### class **X::LibCurl** is Exception

Wraps libcurl error code.

  * method **Int**() returns Int

Returns the CURLcode for the error.

  * method **message**() returns Str

Returns the Str version of the error from [**curl_easy_strerror**](https://curl.haxx.se/libcurl/c/curl_easy_strerror.html).

### class **LibCurl::slist-struct** is repr('CStruct')

Wrapper for **struct curl_slist**.

  * has Str $.data

  * has Pointer $.next

### class **LibCurl::slist** is repr('CPointer')

Wrapper for a pointer to a **struct curl_slist**.

  * method **append**(*@str-list) returns LibCurl::slist

Wrapper for [**curl_slist_append**](https://curl.haxx.se/libcurl/c/curl_slist_append.html), but can take a list of strings and they all get appended.

  * method **list**() returns Array

Extract the list of strings into a Perl Array.

  * method **free**()

Wrapper for [**curl_slist_free_all**](https://curl.haxx.se/libcurl/c/curl_slist_free_all.html).

### **LibCurl::certinfo** is repr('CStruct')

### **LibCurl::EasyHandle** is repr('CStruct')

Wrapper for **struct CURL**.

  * method **new**() returns LibCurl::EasyHandle

Wrapper for [**curl_easy_init**](https://curl.haxx.se/libcurl/c/curl_easy_init.html) to create a new CURL easy handle.

  * method **id**() returns Str

Returns an opaque string that will be unique for every **LibCurl::EasyHandle**.

  * method **cleanup**()

Wrapper for [**curl_easy_cleanup**](https://curl.haxx.se/libcurl/c/curl_easy_cleanup.html).

  * method **reset**()

Wrapper for [**curl_easy_reset**](https://curl.haxx.se/libcurl/c/curl_easy_reset.html).

  * method **duphandle**() returns LibCurl::EasyHandle

Wrapper for [**curl_easy_duphandle**](https://curl.haxx.se/libcurl/c/curl_easy_duphandle.html).

  * method **escape**(Str $str, $encoding = 'utf-8')

Wrapper for [**curl_easy_escape**](https://curl.haxx.se/libcurl/c/curl_easy_escape.html).

  * method **unescape**(Str $str, $encoding = 'utf-8')

Wrapper for [**curl_easy_unescape**](https://curl.haxx.se/libcurl/c/curl_easy_unescape.html).

  * method **perform**() return uint32

Wrapper for [**curl_easy_perform**](https://curl.haxx.se/libcurl/c/curl_easy_perform.html).

  * multi method **setopt**($option, Str $param)

  * multi method **setopt**($option, &callback)

  * multi method **setopt**($option, Pointer $ptr)

  * multi method **setopt**($option, LibCurl::slist $slist)

  * multi method **setopt**($option, CArray[uint8] $ptr)

  * multi method **setopt**($option, LibCurl::EasyHandle $ptr)

Wrappers for various flavors of  [**curl_easy_setopt**](https://curl.haxx.se/libcurl/c/curl_easy_setopt.html).

These will throw an X::LibCurl on any error.

  * method **getinfo_long**($option) returns long

  * method **getinfo_double**($option) returns num64

  * method **getinfo_str**($option) returns Str

  * method **getinfo_certinfo**() returns Array[Str]

  * method **getinfo_slist**($option) returns Array[Str]

Wrappers for various flavors of  [**curl_easy_getinfo**](https://curl.haxx.se/libcurl/c/curl_easy_getinfo.html).

These will throw an X::LibCurl on any error.
