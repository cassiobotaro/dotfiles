# install oh-my-zsh
sudo apt install -y zsh git python-setuptools autojump tree golang ttf-ancient-fonts python-pip
cp .zshrc ~/.zshrc
sudo cp monokai-dark.theme /usr/share/xfce4/terminal/colorschemes/
sudo  -H pip install -U virtualenvwrapper
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s $(which zsh)
echo "Now logout and login to effective your changes."
