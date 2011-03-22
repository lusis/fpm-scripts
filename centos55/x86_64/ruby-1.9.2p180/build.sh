#!/usr/bin/env bash

# build deps
yum install -q -y rpm-build readline-devel.x86_64 libffi-devel.x86_64 libyaml-devel.x86_64 zlib-devel.x86_64 openssl-devel.x86_64

# build dirs
mkdir installtmp
mkdir buildroot

# src files
wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.2-p180.tar.gz
tar -zxvf ruby-1.9.2-p180.tar.gz -C buildroot

# build
cd buildroot/ruby-1.9.2-p180/
./configure --prefix=/usr
make
make install DESTDIR=../../installtmp
cd ../../

# package
fpm --prefix=/ -s dir -t rpm -n ruby -v 1.9.2p180 -C installtmp \
	-p ruby-VERSION_ARCH.rpm \
	-d "libstdc++ >= 4.1.2" \
	-d "glibc >= 2.5" \
	-d "libffi >= 3.0.5" \
	-d "zlib >= 1.2.3" \
	-d "readline >= 5.1" \
	-d "libyaml >= 0.1.2" \
	-d "openssl >= 0.9.8"


