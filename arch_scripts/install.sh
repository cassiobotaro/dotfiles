yaourt -R google-chromium
yaourt -S chromedriver google-chrome slack-desktop git-core ctags ncurses curl spotify tmux neovim python-neovim python-pip zsh xclip phantomjs git autojump tree oh-my-zsh-git docker-compose docker geckodriver go tlp tlp-rdw ttf-dejavu vim gvim powerline-fonts ttf-ancient-fonts the_silver_searcher xfce4-clipman-plugin
chsh -s $(which zsh)
sudo tlp start
systemctl start docker
systemctl enable docker
sudo usermod -aG docker $USER
su - $USER
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Knack Regular Nerd Font Complete Mono.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Hack/Regular/complete/Knack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf
cd ~
mkdir -p go
mkdir -p go/{src,bin}
go get -u github.com/golang/dep/cmd/dep
go get -u github.com/derekparker/delve/cmd/dlv
go get -u github.com/kardianos/govendor
go get -u golang.org/x/tools/cmd/present
go get -u github.com/alecthomas/gometalinter
gometalinter -i
pip install --user --upgrade virtualenvwrapper flake8-bugbear jedi ipython  bandit pylint pydocstyle
mkdir -p ~/.config/nvim
cp .zshrc ~/
cp .gitconfig ~/
cp .tmux.conf ~/
cp init.vim ~/.config/nvim
cp local_init.vim ~/.config/nvim
cp local_bundles.vim ~/.config/nvim
cp .vimrc ~/
cp .vimrc.local ~/
cp .vimrc.local.bundles ~/
