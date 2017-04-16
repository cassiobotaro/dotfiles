#!/bin/sh
sudo apt install -y zsh git autojump tree ttf-ancient-fonts python-pip tmux
sudo  -H pip install -U virtualenvwrapper pip
cp ../.zshrc ~/.zshrc
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo "Now type \`chsh -s $(which zsh)\` to zsh becomes default."
echo "Logout and login to effective your changes."
