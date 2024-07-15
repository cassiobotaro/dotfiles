#!/bin/bash
# install fonts
sudo apt install curl
mkdir -p ~/.local/share/fonts
latest_version=$(curl -sSl https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep tag_name | cut -d '"' -f 4)
wget https://github.com/ryanoasis/nerd-fonts/releases/download/"$latest_version"/Hack.zip
unzip Hack.zip -d ~/.local/share/fonts
fc-cache -fv
rm Hack.zip

# missing apps
# google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# spotify
flatpak install -y spotify

# dbeaver
flatpak install -y app/io.dbeaver.DBeaverCommunity/x86_64/stable

# others
sudo apt install build-essential git

# terminal stuffs
sudo apt install zoxide fd-find exuberant-ctags ncurses-term curl xclip tmux zsh exa jq ripgrep shellcheck
sudo ln -s "$(which fdfind)" /usr/bin/fd
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# github cli
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
sudo apt update
sudo apt install gh
gh auth login
gh extension install github/gh-copilot

# set preferences
mkdir -p ~/Projects
gh repo clone dotfiles ~/Projects/dotfiles
cd ~/Projects/dotfiles || exit 1

cp .zshrc ~/
cp .gitignore ~/
cp .tmux.conf ~/
cp .gitconfig ~/

# python dependencies
sudo apt-get update
sudo apt-get install --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# asdf
latest_version=$(curl -sSl https://api.github.com/repos/asdf-vm/asdf/releases/latest | grep tag_name | cut -d '"' -f 4)
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch "$latest_version"
su - "$USER"

# mise
curl https://mise.run | sh

# bat
mise use --global bat@latest

# eza
mise use --global eza@latest

# lazydocker
mise plugin add lazydocker https://github.com/comdotlinux/asdf-lazydocker.git
mise use --global lazydocker@latest

# neovim
mise use --global neovim@latest

# minikube
mise use --global minikube@latest

# kubectl
mise use --global kubectl@latest

# kubectx
mise use --global kubectx@latest

# k9s
mise use --global k9s@latest

# fzf
mise plugin add fzf https://github.com/kompiro/asdf-fzf.git
mise plugin install fzf
~/.local/share/mise/installs/fzf/"$(fzf --version | cut -d" " -f 1)"/install --all

# python
mise use --global python@latest
cp .pdbrc ~/
upy

# go
mise use --global go@latest

# nodejs
mise use --global node@latest

# docker
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker "$USER"

# END
su - "$USER"
