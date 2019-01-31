#!/bin/sh
sudo apt install -y wget curl
CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`
wget https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip
python3 -m zipfile -e chromedriver_linux64.zip .
chmod +x chromedriver
sudo mv chromedriver /usr/local/bin
rm -R chromedriver_linux64.zip
