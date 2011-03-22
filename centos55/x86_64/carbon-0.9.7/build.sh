#!/usr/bin/env bash

# build deps
yum install -q -y rpm-build python-setuptools.noarch python-pip.noarch

# build dirs
mkdir installtmp
mkdir buildroot

# src files
easy_install --editable --build-directory buildroot "carbon ==0.9.7"

# build
cd buildroot/carbon
python setup.py bdist
cd dist
tar -zxvf carbon-0.9.7.linux-x86_64.tar.gz -C ../../../installtmp/
cd ../../../installtmp/

# package
fpm --prefix=/opt -s dir -t rpm -n python-carbon -v 0.9.7 -C opt -p python-carbon-0.9.7.x86_64.rpm \
	-d "python" \
	-d "python-twisted 10.2.0" \
	-d "python-txamqp 0.4"

# verify
rpm -qip --filesbypkg python-carbon-0.9.7.x86_64.rpm
