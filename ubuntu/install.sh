#!/bin/bash
# install fonts
mkdir -p ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip
unzip Hack.zip -d ~/.local/share/fonts
fc-cache -fv
rm Hack.zip

# missing apps
# google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# spotify
sudo apt install curl
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client

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

# bat
wget https://github.com/sharkdp/bat/releases/download/v0.23.0/bat_0.23.0_amd64.deb
sudo dpkg -i bat_0.23.0_amd64.deb
rm bat_0.23.0_amd64.deb

# set preferences
cp .zshrc ~/
cp .gitignore ~/
cp .tmux.conf ~/
cp .gitconfig ~/

# python dependencies
sudo apt-get update
sudo apt-get install --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1
su - "$USER"

# python
asdf plugin add python
asdf install python latest
asdf global python latest
cp .pdbrc ~/
upy

# go
asdf plugin add golang
asdf_update golang

# rust
asdf plugin add rust
asdf_update rust

# fzf
asdf plugin add fzf
asdf_update fzf
~/.asdf/installs/fzf/"$(fzf --version | cut -d" " -f 1)"/install --all

# neovim
asdf plugin add neovim
asdf_update neovim

# nodejs
asdf plugin add nodejs
asdf_update nodejs

# minikube
asdf plugin add minikube
asdf_update minikube

# kubectl
asdf plugin add kubectl
asdf_update kubectl

# kubectx
asdf plugin add kubectx
asdf_update kubectx

# helm
asdf plugin add helm
asdf_update helm

# docker
sudo apt-get install \
	ca-certificates \
	curl \
	gnupg \
	lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker "$USER"

# vscode
wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O vscode.deb
sudo dpkg -i vscode.deb
rm vscode.deb

# change caps to esc
dconf write "/org/gnome/desktop/input-sources/xkb-options" "['caps:escape']"

# END
su - "$USER"
