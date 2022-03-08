
# package manager
sudo pacman -S yay
# add colors to yay
sudo sed -i 's/#Color/Color/g' /etc/pacman.conf

# install fonts
yay -S ttf-nerd-fonts-hack-complete-git noto-fonts-emoji

# missing apps
yay -S base-devel google-chrome gimp redshift tlp vlc spotify
sudo tlp start

# terminal stuffs
yay -S fasd fd tree ctags ncurses curl bat xclip tmux zsh github-cli neovim
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# set preferences
cp .zshrc ~/
cp .tmux.conf ~/
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim
cp .gitconfig ~/
cp terminalrc ~/.config/xfce4/terminal/
chsh -s $(which zsh)
# python environment
yay -S openssl zlib xz tk
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
pyenv install 3.9.2
pyenv global 3.9.2
pyenv rehash
cp .pdbrc ~/
python -m pip install --user -U neovim jedi isort flake8 black cookiecutter docker-compose pip poetry wheel mypy
# poetry (python env)
mkdir $ZSH_CUSTOM/plugins/poetry
poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry
# go stuffs
yay -S go
# other dev stuffs
yay -S docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
yay -S graphviz
# END
su - $USER
sudo chown -R "$USER:$USER" "$ZSH_CACHE_DIR"
