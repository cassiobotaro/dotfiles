# Install Phantomjs

# Install dependencies

	sudo apt-get install fontconfig

# Download and extract phantomjs from bitbucket

	wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
	tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2

# move to opt directory

	sudo mv phantomjs-2.1.1-linux-x86_64 /opt/phantomjs

# Create symbolic link

	sudo ln -sf /opt/phantomjs/bin/phantomjs /usr/local/bin

# To test only run

	phantomjs --version

