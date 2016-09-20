# install oh-my-zsh
sudo apt install -y zsh git autojump tree golang ttf-ancient-fonts python-pip
sudo  -H pip install -U virtualenvwrapper
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
wget https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme
mv bullet-train.zsh-theme ~/.oh-my-zsh/themes/
cp .zshrc ~/.zshrc
echo "Now type \`chsh -s $(which zsh)\` to zsh becomes default."
echo "Logout and login to effective your changes."
