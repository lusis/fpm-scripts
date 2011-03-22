#!/usr/bin/env bash

# build deps
yum install -q -y rpm-build python-setuptools.noarch python-pip.noarch

# build dirs
mkdir installtmp
mkdir buildroot

# src files
easy_install --editable --build-directory buildroot "graphite-web ==0.9.7c"

# build
cd buildroot/graphite-web
python setup.py bdist
cd dist
tar -zxvf graphite-web-0.9.7c.linux-x86_64.tar.gz -C ../../../installtmp/
cd ../../../installtmp/

# package
fpm --prefix=/opt -s dir -t rpm -n graphite-web -v 0.9.7c -C opt -p python-graphite-web-0.9.7c.noarch.rpm -d "python"

# verify
rpm -qip --filesbypkg python-graphite-web-0.9.7c.noarch.rpm
