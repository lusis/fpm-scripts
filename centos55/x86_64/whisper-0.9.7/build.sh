#!/usr/bin/env bash

# build deps
yum install -q -y rpm-build python-setuptools.noarch python-pip.noarch

# build dirs
mkdir installtmp
mkdir buildroot

# src files
easy_install --editable --build-directory buildroot "whisper ==0.9.7"

# build
cd buildroot/whisper
python setup.py bdist
cd dist
tar -zxvf whisper-0.9.7.linux-x86_64.tar.gz -C ../../../installtmp/
cd ../../../installtmp/

# package
fpm --prefix=/usr -s dir -t rpm -n python-whisper -v 0.9.7 -C usr -p python-whisper-0.9.7.x86_64.rpm \
	-d "python"

# verify
rpm -qip --filesbypkg python-whisper-0.9.7.x86_64.rpm
