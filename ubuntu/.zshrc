# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# 256-color
export TERM="xterm-256color"

# THEME
ZSH_THEME="steeef"

DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
    git
    extract
    fasd
    tmux
    sudo
    poetry
    gh
    nvm
    changie
    rust
)

source $ZSH/oh-my-zsh.sh
export EDITOR='nvim'


alias cat=bat
alias docker=podman
alias zshconf="nvim ~/.zshrc"
alias nvimconf="nvim ~/.config/nvim/init.vim"
alias tree="tree -C"
alias myip="curl http://ipecho.net/plain; echo"
# vnp on/off
alias vpnon="sudo vpnc /etc/vpnc/vpn-ML.conf"
alias vpnoff="sudo vpnc-disconnect"

# fzf
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# postgres client
function pgcli(){
    podman run --rm -ti --name=pgcli --net=host \
    postgres:alpine psql postgres://${PGUSER:-"postgres"}:${PGPASS:-"postgres"}@${PGHOST:-"localhost"}:${PGPORT:-5432}/${PGDATABASE:-"postgres"}
}

# update python packages
function upy(){
    python -m pip install -U pip
    python -m pip uninstall -y neovim jedi isort flake8 black cookiecutter docker-compose wheel poetry httpie
    python -m pip install --user -U -f neovim jedi isort flake8 black cookiecutter docker-compose wheel poetry httpie
}

# clean python thrash
function pyclean(){
    find . -name "*.pyc" | xargs rm -rf
    find . -name "*.pyo" | xargs rm -rf
    find . -name "__pycache__" -type d | xargs rm -rf
    find . -name ".mypy_cache" -type d | xargs rm -rf
}

PATH=~/.local/bin:$PATH
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin

# avoid to save env vars
export HISTORY_IGNORE="export*"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export GTK_IM_MODULE="uim"
export QT_IM_MODULE="uim"
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
