NAME
====

LibCurl::Easy

SYNOPSIS
========

    use LibCurl::Easy;

    my $curl = LibCurl::Easy.new(URL => 'http://example.com');

    $curl.setopt(:verbose, :followlocation);

    $curl.perform;

    say $curl.response-code;

DESCRIPTION
===========

This is a high-level interface to [libcurl](https://curl.haxx.se/libcurl), a free and easy-to-use client-side URL transfer library.

It wraps the low-level interface provided in [LibCurl::EasyHandle](LibCurl::EasyHandle) in some high level constructs that make it a little easier to work with libcurl from Perl.

class **LibCurl::Easy**
-----------------------

The main class for `LibCurl::Easy`.

  * method **new**(*%options) returns LibCurl::Easy

Creates a new `LibCurl::Easy` object and sets up a bunch of default stuff.

You can optionally pass in options and they will get passed directly to `.setopt` after object creation.

  * method **version**() returns Str

Returns human readable version of the curl library. Can be called on a `LibCurl::Easy` object:

    say $curl.version;

or on the LibCurl::Easy type directly as a class method:

    say LibCurl::Easy.version;

  * method **set-header**(*%headers) returns LibCurl::Easy

Set header => 'value' pairs in headers to be sent with a request

  * method **clear-header**() returns LibCurl::Easy

Clear 'extra' outgoing headers.

  * method **setopt**(*%options) returns LibCurl::Easy

Pass options and parameters. See ... for a description of the options.

  * method **perform**() returns LibCurl::Easy

Perform the transaction for this handle. As an alternative, the `LibCurl::Easy` handle can be added to a `LibCurl::Multi` object in which case you don't call perform directly.

  * method **buf**() returns Buf

Received content as a Buf.

  * method **content**($encoding = 'utf-8') returns Str

Received content decoded to a Str.

  * method **error**() returns Str

Human readable ["extra"](https://curl.haxx.se/libcurl/c/CURLOPT_ERRORBUFFER.html) error information that may or may not be available after an error condition.

  * method **receivedheaders**() returns Hash

A Hash of all received headers from the last transaction.

  * method **get-header**(Str $field) returns Str

Get a single from the received headers.

  * method **success**() returns Bool

Is the HTTP response-code 2xx?

  * multi method **getinfo**(Str $info)

Returns a single info object. See ... for a description of all the info fields.

  * multi method **getinfo**(*@fields) returns Hash

Get a hash of specific info fields.

  * multi method **getinfo**() returns Hash

Get all info fields into a Hash.

  * method **cleanup**()

Finish with the handle. If you don't call this explicitly, it will be taken care of with a `DESTROY` handler by the garbage collector, but the timing of that event is uncertain.

Some things, such as the writing of the cookiejar file happen only on cleanup, so it may be useful to explicitly call.

You can use Perl 6 phasers to make calling this easy:

    {
        my $curl will leave { .cleanup } = LibCurl::Easy.new;
    }

As soon as the scope ends, the LEAVE phaser will call the cleanup method on the LibCurl::Easy object. This happens even if an exception causes premature exit from the scope.

  * method **FALLBACK**()

There is a convenience FALLBACK method that catches other methods. It checks for three things:

Is the method an OPTION? If so, call `$curl.setopt()`.

Is the method a received header? If so, return it.

Is the method an INFO field? If so call `$curl.getinfo()`.

This makes it very easy to do things like:

    $curl.URL("http://example.com");
    $curl.download('myfile');

    say $curl.Content-Type;
    say $curl.ETag;
    say $curl.Date;
    say $curl.speed-download;

See ... or ... for the lists.

OPTIONS
=======

...TODO...

INFO fields
===========

...TODO...
