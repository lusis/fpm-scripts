#!/usr/bin/env bash

# build deps
yum install -q -y rpm-build openssl-devel.x86_64

# build dirs
mkdir installtmp
mkdir buildroot

# src files
wget http://nodejs.org/dist/node-v0.4.3.tar.gz
tar -zxvf node-v0.4.3.tar.gz -C buildroot

# build
cd buildroot
./configure --prefix=/usr
make
make install DESTDIR=../../installtmp
cd ../../

# package
fpm --prefix=/ -s dir -t rpm -n node -v 0.3.4 -C installtmp \
	-p node-VERSION_ARCH.rpm \
	-d "libstdc++ >= 4.1.2" \
	-d "glibc >= 2.5" \
	-d "zlib >= 1.2.3" \
	-d "openssl >= 0.9.8"
