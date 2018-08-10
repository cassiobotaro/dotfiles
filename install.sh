git clone https://aur.archlinux.org/yay.git &&\
	cd yay &&\
	makepkg -si &&\
	cd - &&\
	rm -R yay
yay -S slack-desktop git curl spotify tmux gvim python-pip zsh xclip autojump tree oh-my-zsh-git docker-compose docker the_silver_searcher xfce4-clipman-plugin gimp xfce4-whiskermenu-plugin ttf-nerd-fonts-hack-complete-git flake8 python-jedi python-isort ttf-vlgothic ttf-ancient-fonts ttf-ancient-fonts python-pipenv
cp .zshrc ~/
cp .tmux.conf ~/
cp .vimrc ~/
cp .gitconfig ~/
chsh -s $(which zsh)
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
su - $USER
cd ~
go get -u github.com/golang/dep/cmd/dep
go get -u github.com/derekparker/delve/cmd/dlv
go get -u github.com/kardianos/govendor
go get -u golang.org/x/tools/cmd/present
