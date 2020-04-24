#!/bin/sh
sudo apt install -y zsh git autojump tree tmux
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo "Logout and login to effective your changes."
