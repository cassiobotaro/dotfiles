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
snap install spotify

# others
sudo apt install build-essential git

# terminal stuffs
sudo apt install zoxide fd-find exuberant-ctags ncurses-term curl xclip tmux zsh eza jq ripgrep shellcheck
sudo ln -s "$(which fdfind)" /usr/bin/fd
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# github cli
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
sudo apt update
sudo apt install gh

# bat
latest_version=$(curl -sSl https://api.github.com/repos/sharkdp/bat/releases/latest | grep tag_name | cut -d '"' -f 4)
bat_deb="bat_${latest_version#v}_amd64.deb"
wget https://github.com/sharkdp/bat/releases/download/"$latest_version"/"$bat_deb"
sudo dpkg -i "$bat_deb"
rm "$bat_deb"

# set preferences
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

# python
asdf plugin add python
asdf install python latest
asdf global python latest
cp .pdbrc ~/
upy

# go
asdf plugin add golang
asdf_update golang

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

# k9s
asdf plugin add k9s
asdf_update k9s

# docker
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker "$USER"
su - "$USER"

# vscode
wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O vscode.deb
sudo dpkg -i vscode.deb
rm vscode.deb

# END
su - "$USER"
