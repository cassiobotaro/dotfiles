#!/bin/bash
echo "Cloning fonts repository..."
git clone https://github.com/powerline/fonts.git
echo "Installing fonts..."
./fonts/install.sh
sudo rm -r fonts/
sudo apt install -y curl
echo "Install Nerd Font"
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20for%20Powerline%20Nerd%20Font%20Complete.otf
fc-cache -v
echo "Now go to the terminal preferences and change your font."
