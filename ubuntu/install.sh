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
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client
# others
sudo apt install build-essential wget gimp redshift tlp
sudo tlp start

# terminal stuffs
sudo apt install fasd fd-find exuberant-ctags ncurses-term curl xclip tmux zsh exa jq ripgrep
sudo ln -s $(which fdfind) /usr/bin/fd
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# github cli
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
mkdir $ZSH_CUSTOM/plugins/gh
gh completion --shell zsh > $ZSH_CUSTOM/plugins/gh/_gh
# bat
wget https://github.com/sharkdp/bat/releases/download/v0.21.0/bat_0.21.0_amd64.deb
sudo dpkg -i bat_0.21.0_amd64.deb
rm bat_0.21.0_amd64.deb
# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0
# set preferences
cp .zshrc ~/
cp .tmux.conf ~/
mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
cp .gitconfig ~/

# python dependencies
sudo apt-get update; sudo apt-get install --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0

# python
asdf plugin add python
asdf install python latest
asdf global python latest
cp .pdbrc ~/
python -m pip install neovim jedi isort flake8 black cookiecutter poetry wheel httpie
asdf reshim python
mkdir $ZSH_CUSTOM/plugins/poetry
poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry

# go
asdf plugin add golang
asdf install golang latest
asdf global golang latest
go install github.com/miniscruff/changie@latest
asdf reshim golang
mkdir -p $ZSH_CUSTOM/plugins/changie
changie completion zsh > $ZSH_CUSTOM/plugins/changie/_changie

# rust
asdf plugin add rust
asdf install rust latest
asdf global rust latest

# neovim
asdf plugin add neovim
asdf install neovim latest
asdf global neovim latest

# fzf
asdf plugin add fzf
asdf install fzf latest
asdf global fzf latest

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
sudo usermod -aG docker $USER

# graphviz
sudo apt install graphviz

# END
su - $USER
