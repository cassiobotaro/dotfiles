sudo pacman -S docker
sudo systemctl start docker
sudo systemctl enable docker
echo "To give permissions to your user do:"
echo "sudo usermod -aG docker <username>"
echo "su - $USER"