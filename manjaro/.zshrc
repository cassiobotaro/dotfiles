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
    docker-compose
    poetry
    gh
    nvm
    changie
    cargo
    asdf
)

source $ZSH/oh-my-zsh.sh
export EDITOR='nvim'


alias zshconfig="nvim ~/.zshrc"
alias nvimconfig="nvim ~/.config/nvim/init.vim"
alias tree="tree -C"
alias myip="curl http://ipecho.net/plain; echo"
# vnp on/off
alias vpnon="sudo vpnc /etc/vpnc/vpn-ML.conf"
alias vpnoff="sudo vpnc-disconnect"

# fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(nvim {})+abort'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# container monitoring
function ctop() {
    docker run --rm -ti \
        --name=ctop \
        -v /var/run/docker.sock:/var/run/docker.sock \
        quay.io/vektorlab/ctop:latest
}

# postgres client
function pgcli(){
    docker run --rm -ti --name=pgcli --net=host \
    postgres:alpine psql postgres://${PGUSER:-"postgres"}:${PGPASS:-"postgres"}@${PGHOST:-"localhost"}:${PGPORT:-5432}/${PGDATABASE:-"postgres"}
}

# update python packages
function upy(){
    python -m pip install -U pip
    python -m pip install --user -U neovim jedi isort flake8 black cookiecutter docker-compose wheel poetry httpie
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


# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# avoid to save env vars
export HISTORY_IGNORE="export*"

batdiff() {
    git diff --name-only --diff-filter=d | xargs bat --diff
}
