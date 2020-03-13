# package manager
sudo pacman -S yay
# missing apps
yay -S base-devel
yay -S google-chrome spotify gimp redshift tlp vlc
mkdir ~/.cache/vlc
sudo tlp start
# terminal stuffs
yay -S xsel autojump tree ripgrep ttf-nerd-fonts-hack-complete-git ctags ncurses github-cli-bin
yay -S  tmux neovim zsh oh-my-zsh-git
# set preferences
cp .zshrc ~/
cp .tmux.conf ~/
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim
cp .gitconfig ~/
chsh -s $(which zsh)
# python environment
yay -S openssl zlib xz
 git clone https://github.com/pyenv/pyenv.git ~/.pyenv
sudo python -m ensurepip
python -m pip install -U --user neovim jedi isort flake8 black cookiecutter docker-compose pip poetry
# go stuffs
yay -S go
# rust stuff
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# node stuff
yay -S nvm
# other dev stuffs
yay -S docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
# END
su - $USER
sudo chown -R "$USER:$USER" "$ZSH_CACHE_DIR"
