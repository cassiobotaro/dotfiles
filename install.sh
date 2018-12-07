git clone https://aur.archlinux.org/yay.git &&\
	cd yay &&\
	makepkg -si &&\
	cd - &&\
	sudo rm -R yay
yay -S google-chrome slack-desktop git curl spotify tmux neovim python-pip zsh xclip autojump tree oh-my-zsh-git base-devel openssl zlib docker-compose docker the_silver_searcher xfce4-clipman-plugin gimp xfce4-whiskermenu-plugin ttf-nerd-fonts-hack-complete-git bat ttf-vlgothic ttf-ancient-fonts ttf-ancient-fonts ctags ncurses python-neovim python-jedi python-isort python2-neovim flake8 redshift pyenv
cp .zshrc ~/
cp .tmux.conf ~/
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim
cp .gitconfig ~/
chsh -s $(which zsh)
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
su - $USER
