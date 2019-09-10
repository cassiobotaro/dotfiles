#!/bin/sh
# clojure
sudo apt install curl rlwrap openjdk-8-jdk
curl -O https://download.clojure.org/install/linux-install-1.10.1.469.sh
chmod +x linux-install-1.10.1.469.sh
sudo ./linux-install-1.10.1.469.sh
# lein
echo "PATH=~/.local/bin:$PATH" >> ~/.bashrc
curl -O https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
chmod +x lein
mkdir -p ~/.local/bin
mv lein ~/.local/bin
lein