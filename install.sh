#!/bin/bash
# install fonts
sudo apt install curl
mkdir -p ~/.local/share/fonts
latest_version=$(curl -sSl https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep tag_name | cut -d '"' -f 4)
wget https://github.com/ryanoasis/nerd-fonts/releases/download/"$latest_version"/FiraCode.zip
unzip FiraCode.zip -d ~/.local/share/fonts
fc-cache -fv
rm FiraCode.zip

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

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# bat
brew install bat
# eza
brew install eza

# lazydocker
brew install lazydocker

# neovim
brew install neovim

# minikube
brew install minikube

# kubectx
brew install kubectx

# k9s
brew install k9s

# fzf
brew install fzf
./.linuxbrew/Cellar/fzf/"$(fzf --version | cut -d" " -f 1)"/install --all

# asdf
brew install asdf

# python
asdf plugin add python
asdf install python latest
asdf global python latest
cp .pdbrc ~/
upy

# go
asdf plugin add golang
asdf install golang latest
asdf global golang latest

# nodejs
asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest

# docker
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker "$USER"

# END
su - "$USER"
