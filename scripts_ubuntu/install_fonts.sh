#!/bin/bash
git clone https://github.com/powerline/fonts.git
./fonts/install.sh
sudo rm -r fonts/
sudo apt install -y curl
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20for%20Powerline%20Nerd%20Font%20Complete.otf
echo "Now go to the terminal preferences and change your font."
