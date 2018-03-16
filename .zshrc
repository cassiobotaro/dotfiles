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
    virtualenvwrapper
    autojump
    docker
    go
    tmux
    sudo
    docker-compose
    archlinux
)

source $ZSH/oh-my-zsh.sh
export EDITOR='nvim'

alias zshconfig="nvim ~/.zshrc"
alias nvimconfig="nvim ~/.config/nvim/local_init.vim"
alias tree="tree -C"

# go
export GOROOT=/usr/lib/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function ctop() {
    docker run --rm -ti \
        --name=ctop \
        -v /var/run/docker.sock:/var/run/docker.sock \
        quay.io/vektorlab/ctop:latest
}

export NUVEO_DEBUG=true
alias vim=nvim
