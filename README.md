Perl6 LibCurl
=============

A [Perl 6](https://perl6.org/) interface to
[libcurl](https://curl.haxx.se/libcurl/).

    libcurl is a free and easy-to-use client-side URL transfer
    library, supporting DICT, FILE, FTP, FTPS, Gopher, HTTP, HTTPS,
    IMAP, IMAPS, LDAP, LDAPS, POP3, POP3S, RTMP, RTSP, SCP, SFTP,
    SMTP, SMTPS, Telnet and TFTP. libcurl supports SSL certificates,
    HTTP POST, HTTP PUT, FTP uploading, HTTP form based upload,
    proxies, cookies, user+password authentication (Basic, Digest,
    NTLM, Negotiate, Kerberos), file transfer resume, http proxy
    tunneling and more!

    libcurl is highly portable, it builds and works identically on
    numerous platforms, including Solaris, NetBSD, FreeBSD, OpenBSD,
    Darwin, HPUX, IRIX, AIX, Tru64, Linux, UnixWare, HURD, Windows,
    Amiga, OS/2, BeOs, Mac OS X, Ultrix, QNX, OpenVMS, RISC OS, Novell
    NetWare, DOS and more...

    libcurl is free, thread-safe, IPv6 compatible, feature rich, well
    supported, fast, thoroughly documented and is already used by many
    known, big and successful companies and numerous applications.

Examples
========

Simple GET:

    use LibCurl::Easy;

    print LibCurl::Easy.new(URL => 'http://example.com').perform.content;

Fancier:

    use LibCurl::Easy;

    my $curl = LibCurl::Easy.new;
    $curl.setopt(URL => 'http://example.com', download => './myfile.html');
    $curl.perform;
    print $curl.content;
    say $curl.response-code;
    say $curl.statusline;

SEE ALSO
========

There is another Perl 6 interface to libcurl
[Net::Curl](https://github.com/azawawi/perl6-net-curl) developed by
Ahmad M. Zawawi.  If you already use it and it works well for you,
great, keep using it.  Ahmad did a nice job developing it.  I would
encourage you to also take a look at this module.  LibCurl provides a
more 'perlish' OO interface to libcurl than Net::Curl, and wraps
things in a manner to make using it a little easier (IMHO).

LICENSE
=======

Copyright © 2017 United States Government as represented by the
Administrator of the National Aeronautics and Space Administration.
No copyright is claimed in the United States under Title 17,
U.S.Code. All Other Rights Reserved.
