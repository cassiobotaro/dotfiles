#!/bin/bash
wget -qO- https://get.docker.com/ | sh
su - $USER
echo "To give permissions to your user do:"
echo "sudo usermod -aG docker <username>"

