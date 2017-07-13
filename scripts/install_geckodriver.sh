#!/bin/sh
sudo apt install -y wget
wget https://github.com/mozilla/geckodriver/releases/download/v0.18.0/geckodriver-v0.18.0-linux64.tar.gz
extract geckodriver-v0.18.0-linux64.tar.gz
sudo mv geckodriver /usr/local/bin/
rm geckodriver-v0.18.0-linux64.tar.gz
