#!/bin/bash
sudo apt update && sudo apt upgrade

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
sudo snap install spotify

# dbeaver
sudo snap install dbeaver-ce

# others
sudo apt install build-essential git gnome-tweaks

# terminal stuffs
sudo apt install zoxide fd-find exuberant-ctags ncurses-term curl xclip tmux zsh jq ripgrep shellcheck
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
/home/linuxbrew/.linuxbrew/Cellar/fzf/"$(fzf --version | cut -d" " -f 1)"/install --all

# nodejs
latest_version=$(curl -sSl https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep tag_name | cut -d '"' -f 4)
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$latest_version/install.sh" | bash
nvm install --lts
nvm use --lts
npm install -g neovim

# python
curl https://pyenv.run | bash
latest_version=$(pyenv latest -k 3)
pyenv install "$latest_version"
pyenv global "$latest_version"
curl -LsSf https://astral.sh/uv/install.sh | sh
upy

# go
wget "https://go.dev/dl/$(curl -s https://go.dev/dl/ | grep -oP 'go[0-9.]+\.linux-amd64\.tar\.gz' | head -n 1)"
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go*.linux-amd64.tar.gz
rm go*.linux-amd64.tar.gz

# docker
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker "$USER"

# END
su - "$USER"
