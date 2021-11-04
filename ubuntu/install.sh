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
sudo apt install build-essential wget gimp redshift tlp
sudo tlp start

# terminal stuffs
sudo apt install fasd tree ripgrep exuberant-ctags ncurses-term curl xclip tmux zsh
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# nvim
sudo snap install nvim --classic
# github cli
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
mkdir $ZSH_CUSTOM/plugins/gh
gh completion --shell zsh > $ZSH_CUSTOM/plugins/gh/_gh
# bat
wget https://github.com/sharkdp/bat/releases/download/v0.18.3/bat_0.18.3_amd64.deb
sudo dpkg -i bat_0.18.3_amd64.deb
rm bat_0.18.3_amd64.deb
# set preferences
cp .zshrc ~/
cp .tmux.conf ~/
# disable temporarily
# mkdir -p ~/.config/nvim
# cp init.vim ~/.config/nvim
cp .gitconfig ~/
cp terminalrc ~/.config/xfce4/terminal/

# python environment
sudo apt-get update; sudo apt-get install --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
pyenv install 3.9.7
pyenv install 3.10.0
pyenv global 3.9.7
pyenv rehash
cp .pdbrc ~/
upy
# poetry (python env)
mkdir $ZSH_CUSTOM/plugins/poetry
poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry

# Go
wget https://golang.org/dl/go1.17.linux-amd64.tar.gz
sudo  tar -C /usr/local -xzf go1.17.linux-amd64.tar.gz
rm go1.17.linux-amd64.tar.gz
go install github.com/miniscruff/changie@latest
mkdir $ZSH_CUSTOM/plugins/changie
changie completion zsh > $ZSH_CUSTOM/plugins/changie/_changie

# node environment
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install --lts


# rust environment
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# graphviz
sudo apt install graphviz openjdk-17-jre

# magalu
sudo snap install slack --classic
sudo apt install vpnc

# keyboard hack
sudo apt install uim
echo 'export GTK_IM_MODULE="uim"' >> ~/.profile
echo 'export QT_IM_MODULE="uim"' >> ~/.profile
curl 'https://gist.githubusercontent.com/guiambros/b773ee85746e06454596/raw/0ea6d7f7cf9a6ff38b4cafde24dd43852e46d5e3/.XCompose' > ~/.XCompose


# END
su - $USER
