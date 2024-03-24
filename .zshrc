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
    zoxide
    tmux
    sudo
    poetry
    gh
    asdf
    docker-compose
    kubectl
    minikube
)

source $ZSH/oh-my-zsh.sh
export EDITOR='nvim'

# aliases
alias cat="bat -p"
alias ls="exa"
alias tree="ls -T"
alias zshconf="nvim ~/.zshrc"
alias nvimconf="nvim ~/.config/nvim/init.lua"
alias myip="curl http://ipecho.net/plain; echo"
alias vim="nvim"

# fzf
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

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
    [ ! -f export-diagram.js ] && wget https://github.com/cassiobotaro/modeloC4/raw/main/export-diagram.js
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
    # copilot chat requirements
    python -m pip install python-dotenv requests pynvim==0.5.0 prompt-toolkit tiktoken
    asdf reshim python
}

# clean python thrash
function pyclean(){
    find . -name "*.pyc" | xargs rm -rf
    find . -name "*.pyo" | xargs rm -rf
    find . -name "__pycache__" -type d | xargs rm -rf
    find . -name ".mypy_cache" -type d | xargs rm -rf
}

function asdf_update(){
    readonly lang=${1:?"The plugin must be specified."}
    asdf install $lang latest
    asdf global $lang latest
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
