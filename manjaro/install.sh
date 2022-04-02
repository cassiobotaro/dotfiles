
# package manager
sudo pacman -S yay
# add colors to yay
sudo sed -i 's/#Color/Color/g' /etc/pacman.conf

# install fonts
yay -S ttf-nerd-fonts-hack-complete-git noto-fonts-emoji

# missing apps
yay -S base-devel google-chrome gimp redshift tlp vlc spotify
sudo tlp start

# terminal stuffs
yay -S fasd fd tree ctags ncurses curl bat xclip tmux zsh github-cli neovim
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# github cli plugin
mkdir $ZSH_CUSTOM/plugins/gh
gh completion --shell zsh > $ZSH_CUSTOM/plugins/gh/_gh
# set preferences
cp .zshrc ~/
cp .tmux.conf ~/
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim/init.vim
cp .gitconfig ~/
cp terminalrc ~/.config/xfce4/terminal/
chsh -s $(which zsh)

# programming envinroment
# vscode
yay -S  visual-studio-code-bin

# python dependencies
yay -S openssl zlib xz tk

# asdf
yay -S asdf-vm
asdf plugin add python
asdf plugin add nodejs
asdf plugin add rust
asdf plugin add golang

asdf install python 3.10.2
asdf global python 3.10.2
asdf install python 3.9
asdf install rust 1.59.0
asdf global rust 1.59.0
asdf install golang 1.17.8
asdf global golang 1.17.8
asdf install nodejs 17.6.0
asdf global nodejs 17.6.0

# changie (go)
go install github.com/miniscruff/changie@latest
asdf reshim go
changie completion zsh > $ZSH_CUSTOM/plugins/changie/_changie

# pdb config (python)
cp .pdbrc ~/
python -m pip install -U pip
python -m pip install neovim jedi isort flake8 black cookiecutter poetry wheel httpie mypy
asdf reshim python

# poetry (python)
mkdir $ZSH_CUSTOM/plugins/poetry
poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry

# docker
yay -S docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
python -m pip install docker-compose
asdf reshim python

# graphviz
yay -S graphviz

# magalu
yay -S slack-desktop vpnc

# Como desabilitar a opção de "Desabilitar o touchpad enquanto digita"
# 1. Instale xorg-input
# yay -S xorg-xinput
# 2. Rode xinput e anote o ID do touchpad
# xinput
# 3. Liste a propriedades do dispositivo
# utilizando o ID obtido no passo anterior.
# Procure por algo como: "Disable while typing Enabled [number] 1"
# xinput list-props ID
# 4. Modifique a propriedade para falso
# xinput set-prop [id do touchpad obtido no passo 2] [número da configuração que aparece no passo 3] 0
# Exemplo: xinput set-prop 12 302 0

# FIM
su - $USER
