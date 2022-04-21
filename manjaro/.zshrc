# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# THEME
ZSH_THEME="steeef"

# 256-color
export TERM="xterm-256color"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
    git
    extract
    fasd
    tmux
    sudo
    poetry
    gh
    changie
    asdf
    docker-compose
)

source $ZSH/oh-my-zsh.sh
export EDITOR='lvim'

# aliases
alias cat="bat -p"
alias zshconf="nvim ~/.zshrc"
alias lvimconf="lvim ~/.config/lvim/config.lua"
alias tree="tree -C"
alias myip="curl http://ipecho.net/plain; echo"
alias nvim="lvim"
alias vim="lvim"

# vnp on/off
alias vpnon="sudo vpnc /etc/vpnc/vpn-ML.conf"
alias vpnoff="sudo vpnc-disconnect"

# fzf
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# postgres client
function pgcli(){
    docker run --rm -ti --name=pgcli --net=host \
    postgres:alpine psql postgres://${PGUSER:-"postgres"}:${PGPASS:-"postgres"}@${PGHOST:-"localhost"}:${PGPORT:-5432}/${PGDATABASE:-"postgres"}
}

# container monitoring
function ctop() {
    docker run --rm -ti \
        --name=ctop \
        -v /var/run/docker.sock:/var/run/docker.sock \
        quay.io/vektorlab/ctop:latest
}

# structurizr
function structurizr() {
    readonly file=${1:?"The file must be specified."}
    docker run --rm -it \
        -p 8080:8080 \
        -v "$PWD/$file":/usr/local/structurizr/workspace.dsl \
            structurizr/lite
}

# update python packages
function upy(){
    python -m pip install -U pip
    python -m pip install -U neovim jedi isort flake8 black cookiecutter docker-compose wheel poetry httpie
    asdf reshim python
}

# clean python thrash
function pyclean(){
    find . -name "*.pyc" | xargs rm -rf
    find . -name "*.pyo" | xargs rm -rf
    find . -name "__pycache__" -type d | xargs rm -rf
    find . -name ".mypy_cache" -type d | xargs rm -rf
}

# avoid to save env vars
export HISTORY_IGNORE="export*"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
