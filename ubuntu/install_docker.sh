#!/bin/sh
sudo apt install docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
su - $USER
