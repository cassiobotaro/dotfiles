#!/bin/sh
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update
sudo apt install -y  neovim
sudo pip install -u neovim
sudo pip3 install -u neovim
mkdir -p ~/.config/nvim/
cp ../init.vim ~/.config/nvim/
cp ../.vimrc.local.bundles ~/.config/nvim/local_bundles.vim
cp ../.vimrc.local ~/.config/nvim/local_init.vim
nvim +PlugInstall +qall
