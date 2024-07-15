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
    vi-mode
    git
    extract
    zoxide
    tmux
    sudo
    poetry
    gh
    docker-compose
    kubectl
    minikube
    python
)

source $ZSH/oh-my-zsh.sh
export EDITOR='nvim'

# aliases
alias ls="eza"
alias cat="bat -p"
alias tree="ls -T"
alias zshconf="nvim ~/.zshrc"
alias nvimconf="nvim ~/.config/nvim/init.lua"
alias vim="nvim"
alias sysup="sudo apt update && sudo apt upgrade -y"
alias lzd="lazydocker"

# fzf
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# structurizr
function structurizr() {
    readonly file=${1:?"The workspace filename must be specified."}
    if [[ "$file" == *.* ]]; then
        echo "The workspace filename should not contains a file extension."
        return 1
    fi
    if [[ !  -f "./structurizr.properties" ]]; then
        echo "structurizr.autoRefreshInterval=2000" > structurizr.properties
    fi
    docker run --rm -it \
        -p 8080:8080 \
        -u $(id -u ${USER}):$(id -g ${USER}) \
        -v "$PWD":/usr/local/structurizr/ \
        -e STRUCTURIZR_WORKSPACE_FILENAME=$file \
            structurizr/lite
}

function export_c4(){
    readonly format=${1:?"The format must be specified."}
    [ ! -f "./export-diagrams.js" ] && wget https://raw.githubusercontent.com/cassiobotaro/modeloC4/main/export-diagrams.js
    text=$(docker run -i --init --cap-add=SYS_ADMIN --net=host --name=exporter ghcr.io/puppeteer/puppeteer:latest node -e "$(cat export-diagrams.js)"  "" "http://localhost:8080" "$format")
    files=($(echo "$text" | grep -o "\S*\.$format"))
    for file in "${files[@]}"
    do
        docker cp exporter:/home/pptruser/"$file" .
    done
    docker rm exporter
}

# update python packages
function upy(){
    python -m pip install -U pip
    python -m pip install -U cookiecutter poetry wheel ruff neovim httpie
}

eval "$(~/.local/bin/mise activate zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
