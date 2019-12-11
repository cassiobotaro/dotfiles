sudo pacman -S yay
yay -S google-chrome slack-desktop git curl go spotify tmux neovim zsh xclip autojump tree oh-my-zsh-git base-devel openssl zlib xz docker the_silver_searcher gimp ttf-nerd-fonts-hack-complete-git ctags ncurses redshift pyenv tlp
sudo python -m ensurepip
python -m pip install --user neovim jedi isort flake8 black cookiecutter docker-compose
cp .zshrc ~/
cp .tmux.conf ~/
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim
cp .gitconfig ~/
chsh -s $(which zsh)
sudo systemctl enable docker
sudo usermod -aG docker $USER
mkdir ~/.cache/vlc
sudo chown -R "$USER:$USER" "$ZSH_CACHE_DIR"
su - $USER
sudo tlp start
