sudo pacman -S tree zsh git autojump go
sudo python -m ensurepip
sudo python -m pip install --upgrade  virtualenvwrapper
cp ../.zshrc ~/.zshrc
yaourt -S oh-my-zsh-git bullet-train-oh-my-zsh-theme-git --noconfirm
echo "Now type \`chsh -s $(which zsh)\` to zsh becomes default."
echo "Logout and login to effective your changes."