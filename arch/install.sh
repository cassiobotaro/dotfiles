#!/bin/bash
yay -Syy google-chrome neovim ttf-firacode-nerd base-devel spotify zoxide fd ctags ncurses curl xclip tmux zsh jq ripgrep github-cli eza bat neovim fzf lazydocker-bin docker docker-compose
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
gh auth login
gh extension install github/gh-copilot

# set preferences
mkdir -p ~/Projects
gh repo clone dotfiles ~/Projects/dotfiles
cd ~/Projects/dotfiles || exit 1

cp .zshrc ~/
cp .tmux.conf ~/
cp .gitconfig ~/

# python dependencies
yay -S --needed base-devel openssl zlib xz tk zstd

# nodejs
ugjs

# python
ugpy
curl -LsSf https://astral.sh/uv/install.sh | sh
upy

# go
uggo

# docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker "$USER"
su - "$USER"
