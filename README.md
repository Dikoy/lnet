# lnet
Lightweight Networking Library (Delphi/FPC networking library)

## About

lNet or Lightweight Networking Library is a collection of classes and components to enable event-driven TCP or UDP networking. lNet is released under a modified LGPL license. (permits static linking)

## Contains:
The package consists of base lNet units library, lTelnet for telnet protocol, lFTP for ftp protocol and lNetComponents libraries for providing visual and non-visual components for networking. As of 0.4.0 lHTTP and lSMTP components have been added. Since 0.5.1 there’s a MIME support as part of the library mainly for creation of multipart messages for SMTP. Since 0.6.0 lNet supports SSL in a modular way, and SMTP protocol has been extended to full support of SSL/TLS (including runtime STARTTLS negotiation). HTTPS client side is supported too. Since 0.6.5+ IPv6 is also supported.

## Tested on:
The non-visual console components were tested on Win32, Win64, Linux_x86_32, Linux_x86_64, Linux_PPC, Linux_PPC_64, Linux_ARM* (2.1.4+) and FreeBSD_x86_32. The visual (lazarus packages) components were tested in Win32, Win64, arm/WinCE, Linux_x86_32, Linux_x86_64 and FreeBSD_x86_32. (gtk1 and gtk2 on unix platforms)

## Short history:
As of version 0.3 the package is only single-threaded. I’ve dropped multithreaded version and now use exclusively LCL features to work.

As of version 0.4 the package has “eventers” which enable per-OS optimalizations and additional flexibility including watching for events on files additionaly to the sockets.

Version 0.5 changed some high level higher protocol API (ftp, http etc.)

Since 0.5.1 WinCE is considered an unstable but supported platform.

Version 0.6 is highly compatible to previous releases.
