# package manager
sudo pacman -S yay
# missing apps
yay -S base-devel
yay -S google-chrome gimp redshift tlp vlc
mkdir ~/.cache/vlc
sudo tlp start
# spotify is not working from repository, then use snap
snap install spotify
# terminal stuffs
yay -S autojump tree ripgrep ttf-nerd-fonts-hack-complete-git ctags ncurses github-cli noto-fonts-emoji bat xclip
yay -S tmux neovim zsh oh-my-zsh-git
# set preferences
cp .zshrc ~/
cp .tmux.conf ~/
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim
cp .gitconfig ~/
cp .gitatributtes ~/
cp terminalrc ~/.config/xfce4/terminal/
chsh -s $(which zsh)
# python environment
yay -S openssl zlib xz tk
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
pyenv install 3.9.0
pyenv global 3.9.0
pyenv rehash
python -m pip install --user -U neovim jedi isort flake8 black cookiecutter docker-compose pip poetry
# go stuffs
yay -S go
# rust stuff
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# node stuff
yay -S nvm
# other dev stuffs
yay -S docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
# END
su - $USER
sudo chown -R "$USER:$USER" "$ZSH_CACHE_DIR"
