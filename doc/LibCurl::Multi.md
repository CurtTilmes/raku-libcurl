NAME
====

LibCurl::Multi

SYNOPSIS
========

    use LibCurl::Easy;
    use LibCurl::Multi;

    my $curl = LibCurl::Easy.new(URL => 'http://example.com');

    sub callback(LibCurl::Easy $easy, Exception $e)
    {
        die $e if $e;
        say $easy.statusline;
    }

    my $multi = LibCurl::Multi.new(callback => &callback);

    $multi.add-handle($curl);

    $multi.perform;

DESCRIPTION
===========

This is a high-level interface to the libcurl [multi interface](https://curl.haxx.se/libcurl/c/libcurl-multi.html).

It wraps the low-level interface provided in [LibCurl::MultiHandle](LibCurl::MultiHandle) in some high level constructs that make it a little easier to work with.

class **LibCurl::Multi**
------------------------

  * method **new**(*%options) returns LibCurl::Multi

Creates a new `LibCurl::Multi` object. You can optionally pass in options and they will get passed directly to `.setopt` after object creation.

  * method **setopt**(*%options) returns LibCurl::Multi

Pass options and parameters. See ... for a description of the options.

A special extra option `callback` allows you to specify a callback function that will get called when any `LibCurl::Easy` completes its work.

  * method **add-handle**(*@handles) returns LibCurl::Multi

Add `LibCurl::Easy` objects to the `LibCurl::Multi`.

  * method **remove-handle**(*@handles) returns LibCurl::Multi

Remove `LibCurl::Easy` objects from the `LibCurl::Multi`.

In general you shouldn't need to remove them directly, they will get removed as they complete. If you want to abort a transfer for any reason, you can remove them prior to that.

  * method **perform**($timeout-ms = 1000) returns LibCurl::Multi

Main loop to perform all the transfers.

As each transfer completes, the handles are removed, and if a callback is set, that gets called.
