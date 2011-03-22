#!/usr/bin/env bash

# build deps
yum install -q -y rpm-build python-setuptools.noarch python-pip.noarch python-devel.x86_64

# build dirs
mkdir installtmp
mkdir buildroot

# src files
easy_install --editable --build-directory buildroot "Twisted ==10.2.0"

# build
cd buildroot/twisted
python setup.py bdist
cd dist
tar -zxvf Twisted-10.2.0.linux-x86_64.tar.gz -C ../../../installtmp/
cd ../../../installtmp/

# package
fpm --prefix=/usr -s dir -t rpm -n python-twisted -v 10.2.0 -C usr -p python-twisted-10.2.0.x86_64.rpm \
	-d "python" \
	-d "libstdc++ >= 4.1.2" \
	-d "glibc >= 2.5"

# verify
rpm -qip --filesbypkg python-twisted-10.2.0.x86_64.rpm
