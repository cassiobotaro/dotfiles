#!/bin/bash
# install fonts
mkdir -p ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
unzip Hack.zip -d ~/.local/share/fonts
fc-cache -fv
rm Hack.zip

# missing apps
# google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb
# spotify
sudo snap install spotify
# others
sudo apt install build-essential git

# terminal stuffs
sudo apt install fasd fd-find exuberant-ctags ncurses-term curl xclip tmux zsh exa jq ripgrep
sudo ln -s "$(which fdfind)" /usr/bin/fd
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# github cli
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
mkdir "$ZSH_CUSTOM/plugins/gh"
gh completion --shell zsh > "$ZSH_CUSTOM/plugins/gh/_gh"
# bat
wget https://github.com/sharkdp/bat/releases/download/v0.22.1/bat_0.22.1_amd64.deb
sudo dpkg -i bat_0.22.1_amd64.deb
rm bat_0.22.1_amd64.deb

# set preferences
cp .zshrc ~/
cp .tmux.conf ~/
cp .gitconfig ~/

# python dependencies
sudo apt-get update; sudo apt-get install --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2

# python
asdf plugin add python
asdf install python latest
asdf global python latest
cp .pdbrc ~/
python -m pip install jedi isort flake8 black cookiecutter poetry wheel httpie ruff neovim
asdf reshim python
mkdir "$ZSH_CUSTOM/plugins/poetry"
poetry completions zsh > "$ZSH_CUSTOM/plugins/poetry/_poetry"

# go
asdf plugin add golang
asdf install golang latest
asdf global golang latest
go install github.com/miniscruff/changie@latest
asdf reshim golang
mkdir -p "$ZSH_CUSTOM/plugins/changie"
changie completion zsh > "$ZSH_CUSTOM/plugins/changie/_changie"

# rust
asdf plugin add rust
asdf install rust latest
asdf global rust latest

# fzf
asdf plugin add fzf
asdf install fzf latest
asdf global fzf latest
~/.asdf/installs/fzf/$(fzf --version | cut -d" " -f 1)/install --all

# java
asdf plugin-add java https://github.com/halcyon/asdf-java.git
asdf install java openjdk-19
asdf global java openjdk-19

# neovim
asdf plugin add neovim
asdf install neovim stable
asdf global neovim stable

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
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker "$USER"

# vscode
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code

# END
su - "$USER"
