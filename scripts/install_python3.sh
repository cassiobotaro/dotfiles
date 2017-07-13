#!/bin/sh
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev nxz-utils tk-dev
cd ~
wget https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz
extract Python-3.6.1.tgz
./configure  --enable-optimizations --prefix=/home/cassiobotaro/python3.6
make
make install
