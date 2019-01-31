#!/bin/sh
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev python3-pip
 git clone https://github.com/pyenv/pyenv.git ~/.pyenv
sudo -H python3 -m pip  install neovim virtualenvwrapper jedi flake8 isort
