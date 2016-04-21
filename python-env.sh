sudo apt-get install -y python-dev python3-dev python-pip
sudo -H pip install -U  virtualenvwrapper jupyter flake8 docker-compose ipdb
ipython --version
cp ipython_config.py ~/.ipython/profile_cassiobotaro/
echo 'source /usr/local/bin/virtualenvwrapper.sh' >> ~/.bashrc
