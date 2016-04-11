# install oh-my-zsh
sudo apt-get install -y zsh git python-setuptools autojump tree golang ttf-ancient-fonts
# cp .gitconfig ~/.gitconfig
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
sh install-fonts.sh
sudo easy_install pip
sudo pip install virtualenvwrapper
wget https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme
mv bullet-train.zsh-theme ~/.oh-my-zsh/themes/
chsh -s $(which zsh)
cp .zshrc ~/.zshrc
