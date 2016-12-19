#!/bin/sh
sudo apt install -y zsh git autojump tree ttf-ancient-fonts python-pip tmux
sudo  -H pip install -U virtualenvwrapper pip
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
