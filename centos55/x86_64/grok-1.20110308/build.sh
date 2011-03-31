#!/usr/bin/env bash

# build deps
yum install -q -y rpm-build openssl-devel.x86_64 libevent.x86_64 libevent-devel.x86_64 pcre.x86_64 pcre-devel.x86_64 tokyocabinet.x86_64 tokyocabinet-devel.x86_64 gperf.x86_64

# build dirs
mkdir installtmp
mkdir buildroot

# src files
wget http://semicomplete.googlecode.com/files/grok-1.20110308.1.tar.gz
tar -zxvf grok-1.20110308.1.tar.gz -C buildroot

# build
cd buildroot
make
make install DESTDIR=../../installtmp
cd ../../

# package
fpm --prefix=/ -s dir -t rpm -n grok -v 1.20110308 -C installtmp \
	-p grok-VERSION.ARCH.rpm \
	-d "tokyocabinet >= 1.4.9" \
	-d "glibc >= 2.5" \
	-d "libevent >= 1.4.13" \
	-d "gperf >= 3.0.1" \
	-d "pcre >= 6.6"

rpm -qip grok-1.20110308.x86_64.rpm
