# Path to your oh-my-zsh installation.
export ZSH="/usr/share/oh-my-zsh"

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
    pyenv
)

source $ZSH/oh-my-zsh.sh
export EDITOR='nvim'


alias zshconfig="nvim ~/.zshrc"
alias nvimconfig="nvim ~/.config/nvim/init.vim"
alias tree="tree -C"

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
    echo "postgres://${PGUSER:-"postgres"}:${PGPASS:-"postgres"}@${PGHOST:-"localhost"}:${PGPORT:-5432}/${PGDATABASE:-"postgres"}"
    docker run --rm -ti --name=pgcli --net=host \
    pygmy/pgcli postgres://${PGUSER:-"postgres"}:${PGPASS:-"postgres"}@${PGHOST:-"localhost"}:${PGPORT:-5432}/${PGDATABASE:-"postgres"}
}

# update python packages
function upy(){
    pip install --user -U neovim jedi isort flake8 black cookiecutter docker-compose pip wheel
}

PATH=~/.local/bin:$PATH
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
source $HOME/.cargo/env
source /usr/share/nvm/init-nvm.sh
