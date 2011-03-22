#!/usr/bin/env bash

# build deps
yum install -q -y rpm-build python-setuptools.noarch python-pip.noarch

# build dirs
mkdir installtmp
mkdir buildroot

# src files
easy_install --editable --build-directory buildroot "graphite ==0.71"

# build
cd buildroot
python setup.py bdist
cd dist
tar -zxvf graphite-0.71.linux-x86_64.tar.gz

# package
fpm -e --prefix=/ -s dir -t rpm -n graphite -v 0.71 -C usr -p python-graphite.noarch.rpm -d "python"
