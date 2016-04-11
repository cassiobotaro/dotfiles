sudo apt-get install -y vim vim-gtk git exuberant-ctags ncurses-term silversearcher-ag curl
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20for%20Powerline%20Nerd%20Font%20Complete.otf
sed -i -e 's/FontName=.*/FontName=Droid Sans Mono for Powerline 11/g' ~/.config/xfce4/terminal/terminalrc
sudo -H pip install -U flake8 autopep8 isort
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd -
cp .vimrc ~/.vimrc
vim +PlugInstall
