#!/bin/bash
sudo apt update && sudo apt upgrade

# github cli
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
sudo apt update
sudo apt install gh
gh auth login

# set preferences
mkdir -p ~/Projects
gh repo clone dotfiles ~/Projects/dotfiles
cd ~/Projects/dotfiles || exit 1

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

# snap
sudo snap install spotify dbeaver-ce

# others
sudo apt install build-essential git

# terminal stuffs
sudo apt install zoxide fd-find curl xclip tmux zsh jq ripgrep
sudo ln -s "$(which fdfind)" /usr/bin/fd

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# brew dependencies
sudo apt install luarocks lynx
brew install bat eza lazydocker neovim minikube kubectx fzf
/home/linuxbrew/.linuxbrew/Cellar/fzf/"$(fzf --version | cut -d" " -f 1)"/install --all # fzf install

# docker
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker "$USER"
su - "$USER"

cp .zshrc ~/
cp .tmux.conf ~/
cp .gitconfig ~/

# nodejs
ugjs

# python
# dependencies
sudo apt-get install --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
ugpy
curl -LsSf https://astral.sh/uv/install.sh | sh
upy

# go
uggo
