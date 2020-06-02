#!/bin/sh
# set preferences
cp .tmux.conf ~/
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim
cp .gitconfig ~/
# install docker
sudo apt install docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
su - $USER
# install fonts
sudo apt install curl
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo "Hack Regular Nerd Font Complete Mono.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf
cd -
fc-cache -v
echo "Now, go to \"terminal preferences\" and change your font."
# install golang
sudo snap install --classic go
# install missing applications
sudo apt install -y gimp tlp tlp-rdw xclip build-essential ripgrep vlc libreoffice exuberant-ctags ncurses-term
mkdir ~/.cache/vlc
sudo tlp start
# install neovim
sudo apt install -y neovim
# install nvm
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"
# install oh-my-zsh
cp .zshrc ~/
sudo apt install -y zsh git autojump tree tmux
chsh -s $(which zsh)
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo "Logout and login to effective your changes."
# install python
sudo apt update; sudo apt install --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
pyenv install 3.8.2
pyenv global
pyenv rehash
pip install -U docker-compose poetry flake8 black isort neovim jedi cookiecutter
# install spotify
snap install spotify
# install vscode
sudo snap install code --classic
# END
su - $USER
sudo chown -R "$USER:$USER" "$ZSH_CACHE_DIR"
