# developer tools
sudo apt install build-essential wget

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
# spotify
snap install spotify
# others
sudo apt install gimp redshift tlp vlc
sudo tlp start

# terminal stuffs
sudo apt install fasd tree ripgrep exuberant-ctags ncurses-term curl xclip tmux zsh
sudo snap install nvim --classic
# github cli
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
mkdir $ZSH_CUSTOM/plugins/gh
gh completion --shell zsh > $ZSH_CUSTOM/plugins/gh/_gh
# bat
wget https://github.com/sharkdp/bat/releases/download/v0.18.1/bat_0.18.1_amd64.deb
sudo dpkg -i bat_0.18.1_amd64.deb
rm bat_0.18.1_amd64.deb
# set preferences
cp .zshrc ~/
cp .tmux.conf ~/
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim
cp .gitconfig ~/
cp terminalrc ~/.config/xfce4/terminal/

# python environment
sudo apt-get update; sudo apt-get install --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
pyenv install 3.9.5
pyenv global 3.9.5
pyenv rehash
cp .pdbrc ~/
upy
# poetry (python env)
mkdir $ZSH_CUSTOM/plugins/poetry
poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry
# Go
wget https://golang.org/dl/go1.16.4.linux-amd64.tar.gz
sudo  tar -C /usr/local -xzf go1.16.4.linux-amd64.tar.gz
# docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
# graphviz and java (required by plantuml)
sudo apt install graphviz openjdk-14-jdk

# avoid vlc bug with subtitles
mkdir ~/.cache/vlc

# END
su - $USER
sudo chown -R "$USER:$USER" "$ZSH_CACHE_DIR"
