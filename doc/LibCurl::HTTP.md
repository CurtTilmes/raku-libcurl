NAME
====

LibCurl::HTTP

SYNOPSIS
========

    use LibCurl::HTTP;

    my $http = LibCurl::HTTP.new;

    say $http.GET('http://example.com').perform.content;

    say $http.GET('http://example.com', 'myfile').perform.response-code;

    say $http.HEAD('http://example.com').perform.response-code;

    $http.DELETE('http://example.com').perform;

    $http.PUT('http://example.com', 'myfile').perform;

    $http.POST('http://example.com/form.html', 'name=foo&opt=value').perform;

DESCRIPTION
===========

A thin subclass of `LibCurl::Easy` that adds extra methods for the main HTTP methods.

METHODS
-------

  * method **GET**($URL, $filename?)

Set :httpget, URL => $URL, download => $filename.

  * method **HEAD**($URL)

Set :nobody, URL => $URL

  * method **DELETE**($URL)

Set customrequest => 'DELETE', URL => $URL

  * method **PUT**($URL, $filename)

Set URL => $URL, upload => $filename

  * method **POST**($URL, $content)

Set URL => $URL, postfields => $content
