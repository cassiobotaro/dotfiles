# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# THEME
ZSH_THEME="steeef"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
    git
    fzf
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
    eza
)

source $ZSH/oh-my-zsh.sh
export EDITOR='nvim'

# aliases
alias cat="bat -p"
alias tree="ls -T"
alias zshconf="nvim ~/.zshrc"
alias nvimconf="nvim ~/.config/nvim/init.lua"
alias vim="nvim"
alias sysup="yay -Syu"
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
    python -m ensurepip
    pyenv rehash
    python -m pip install -U pip
    python -m pip install -U cookiecutter poetry wheel ruff neovim httpie
    uv self update
}

# upgrade language versions
function ugpy(){
    if ! command -v pyenv &> /dev/null; then
        echo "pyenv não encontrado. Instalando pyenv..."
        git clone https://github.com/pyenv/pyenv.git ~/.pyenv
        export PATH="$HOME/.pyenv/bin:$PATH"
        eval "$(pyenv init --path)"
        eval "$(pyenv init -)"
        git clone https://github.com/pyenv/pyenv-update.git $(pyenv root)/plugins/pyenv-update
    fi

    pyenv update
    latest_version=$(pyenv latest -k 3)
    pyenv install -s "$latest_version"
    pyenv global "$latest_version"
}

function uggo(){
    wget "https://go.dev/dl/$(curl -s https://go.dev/dl/ | grep -oP 'go[0-9.]+\.linux-amd64\.tar\.gz' | head -n 1)"
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go*.linux-amd64.tar.gz
    rm go*.linux-amd64.tar.gz
}

ugjs() {
  # Busca a versão mais recente do nvm
  latest_version=$(curl -sSl https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep tag_name | cut -d '"' -f 4)

  # Verifica se o nvm está instalado e sua versão
  if command -v nvm >/dev/null 2>&1; then
    current_version=$(nvm --version 2>/dev/null)
    # Remove "v" do início, se existir
    current_version="v${current_version}"
  else
    current_version=""
  fi

  # Instala ou atualiza o nvm se necessário
  if [ "$current_version" != "$latest_version" ]; then
    echo "Instalando ou atualizando nvm para a versão $latest_version..."
    curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$latest_version/install.sh" | bash
    # Carrega o nvm após instalação/atualização
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  fi

  # Sempre instala e usa a última LTS do Node.js
  nvm install --lts
  nvm use --lts

  # Instala o neovim globalmente via npm
  npm install -g neovim
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"


export PATH=$PATH:~/go/bin:/usr/local/go/bin

. "$HOME/.local/bin/env"
