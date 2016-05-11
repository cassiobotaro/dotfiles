sudo apt-get install -y vim vim-gtk git exuberant-ctags ncurses-term silversearcher-ag curl python-pip python3-pip
sudo -H pip install -U flake8
sudo -H pip3 install -U autopep8 isort
cp .vimrc ~/.vimrc
cp .vimrc.local ~/
cp .vimrc.local.bundles ~/
vim +PlugInstall
