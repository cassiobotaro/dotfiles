yaourt -S slack-desktop git ctags ncurses curl spotify tmux neovim python-neovim python-pip zsh xclip autojump tree oh-my-zsh-git docker-compose docker go powerline-fonts the_silver_searcher xfce4-clipman-plugin gimp xfce4-whiskermenu-plugin ttf-nerd-fonts-knack-complete-git flake8 python-jedi jupyter autopep8 python-isort ttf-vlgothic ttf-ancient-fonts
cp /usr/share/oh-my-zsh/zshrc ~/.zshrc
chsh -s $(which zsh)
systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
su - $USER
cd ~
export GOROOT=/usr/lib/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
go get -u github.com/golang/dep/cmd/dep
go get -u github.com/derekparker/delve/cmd/dlv
go get -u github.com/kardianos/govendor
go get -u golang.org/x/tools/cmd/present
go get -u github.com/alecthomas/gometalinter
gometalinter -i
sudo pip install --upgrade pipenv radon virtualenvwrapper
mkdir -p ~/.config/nvim
cp .zshrc ~/
cp .gitconfig ~/
cp .tmux.conf ~/
cp init.vim ~/.config/nvim
cp local_init.vim ~/.config/nvim
cp local_bundles.vim ~/.config/nvim
