sudo apt-get install -y vim vim-gtk git exuberant-ctags ncurses-term silversearcher-ag curl
sudo -H pip install -U flake8 autopep8 isort
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp .vimrc ~/.vimrc
vim +PlugInstall
