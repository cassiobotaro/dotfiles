yay -S google-chrome slack-desktop git curl go spotify tmux neovim python-pip zsh xclip autojump tree oh-my-zsh-git base-devel openssl zlib docker-compose docker pigz the_silver_searcher xfce4-clipman-plugin gimp xfce4-whiskermenu-plugin ttf-nerd-fonts-hack-complete-git ttf-vlgothic ttf-ancient-fonts ctags ncurses redshift pyenv  acpi_call lsb-release smartmontools tp_smapi ethtool
pip install --user neovim jedi isort flake8 black
cp .zshrc ~/
cp .tmux.conf ~/
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim
cp .gitconfig ~/
chsh -s $(which zsh)
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
sudo chown -R "$USER:$USER" "$ZSH_CACHE_DIR"
su - $USER
