sudo apt-get install -y python-setuptools python-dev python3-dev
sudo easy_install pip
sudo -H pip install -U  virtualenvwrapper jupyter flake8 docker-compose ipdb
cp python_config.py ~/.ipython/profile_default/
echo 'source /usr/local/bin/virtualenvwrapper.sh' >> ~/.bashrc
