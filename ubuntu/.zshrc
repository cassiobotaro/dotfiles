# Path to your oh-my-zsh installation.
export ZSH="/home/cassiobotaro/.oh-my-zsh"
# THEME
ZSH_THEME="steeef"
# 256-color
export TERM="xterm-256color"
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"
# plugins
plugins=(
    git
    extract
    autojump
    tmux
    sudo
    docker-compose
    pyenv
    nvm
)
# load oh-my-zsh
source $ZSH/oh-my-zsh.sh
# alias
alias zshconfig="nvim ~/.zshrc"
alias nvimconfig="nvim ~/.config/nvim/init.vim"
alias tree="tree -C"
alias vim=nvim

# add local binaries to PATH
PATH=~/.local/bin:$PATH
PATH=~/go/bin:$PATH
# set display for xclip
export DISPLAY=:0

# functions
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

# install python tools
function install_python_tools(){
    pip install -U docker-compose poetry flake8 black isort neovim jedi cookiecutter
}

# fzf
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(nvim {})+abort'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
