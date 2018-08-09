# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh

# 256-color
export TERM="xterm-256color"

# THEME
ZSH_THEME="steeef"

DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
    git
    extract
    autojump
    tmux
    sudo
    docker-compose
)

source $ZSH/oh-my-zsh.sh
export EDITOR='nvim'

alias zshconfig="nvim ~/.zshrc"
alias nvimconfig="nvim ~/.config/nvim/init.vim"
alias tree="tree -C"

# go
export GOROOT=/usr/lib/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# fzf
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
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

alias vim=nvim
