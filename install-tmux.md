#First install tmux

`sudo apt-get install tmux`

#Then install the plugin manager

`git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

#Copy tmux config:

`cp .tmux.conf ~/.tmux.conf`

#Install the plugins:

Inside tmux

Press prefix + I (capital I, as in Install) to fetch the plugin.

#Reload tmux

tmux source ~/.tmux.conf
