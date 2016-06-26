sudo apt install -y python-dev python3-dev python3-pip python-pip
sudo -H pip install -U  virtualenvwrapper jupyter flake8 docker-compose ipdb
mkdir -p ~/.ipython/profile_default/
cp ipython_config.py ~/.ipython/profile_default/
echo 'source /usr/local/bin/virtualenvwrapper.sh' >> ~/.bashrc
