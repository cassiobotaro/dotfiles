sudo apt install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp ../.tmux.conf ~/
tmux source ~/.tmux.conf
echo "Now type \"tmux\" and install plugins."
echo "Press prefix + I (capital I, as in Install) to fetch the plugins."
