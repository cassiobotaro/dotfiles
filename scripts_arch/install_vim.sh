sudo pacman -S the_silver_searcher git-core ctags ncurses  curl gvim
sudo python -m ensurepip
sudo python -m pip install --upgrade flake8 autopep8 isort
cp ../.vimrc ~/.vimrc
cp ../.vimrc.local ~/
cp ../.vimrc.local.bundles ~/
vim +PlugInstall