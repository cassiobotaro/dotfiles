#!/bin/sh
sudo apt install -y wget
wget https://chromedriver.storage.googleapis.com/2.30/chromedriver_linux64.zip
extract chromedriver_linux64.zip
sudo mv chromedriver_linux64/chromedriver /usr/local/bin
rm -R chromedriver_linux64 chromedriver_linux64.zip
