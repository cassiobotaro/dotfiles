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
    uv
    nvm
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
    if [[ ! -f "./structurizr.properties" ]]; then
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
    docker rm -f exporter 2>/dev/null || true
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
    current_version=$(pyenv global 2>/dev/null)

    if [ "$current_version" = "$latest_version" ]; then
        echo "Python já está na versão mais recente ($current_version)"
        return 0
    else
        echo "Atualizando Python de $current_version para $latest_version..."
    fi

    pyenv install -s "$latest_version"
    pyenv global "$latest_version"
}

function uggo(){
    latest_version=$(curl -s https://go.dev/dl/ | grep -oP 'go[0-9.]+\.linux-amd64\.tar\.gz' | head -n 1 | sed 's/go\([0-9.]*\)\.linux-amd64\.tar\.gz/\1/')
    current_version=$(go version 2>/dev/null | grep -oP 'go[0-9.]+' | head -n 1 | sed 's/go//')

    if [ -z "$current_version" ]; then
        echo "Go não encontrado. Instalando versão $latest_version..."
    elif [ "$current_version" = "$latest_version" ]; then
        echo "Go já está na versão mais recente ($current_version)"
        return 0
    else
        echo "Atualizando Go de $current_version para $latest_version..."
    fi

    wget "https://go.dev/dl/go${latest_version}.linux-amd64.tar.gz"
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go*.linux-amd64.tar.gz
    rm go*.linux-amd64.tar.gz
}

ugjs() {

  if ! command -v nvm >/dev/null 2>&1; then
    echo "NVM não encontrado. Instalando..."
    latest_nvm_version=$(curl -sSl https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep tag_name | cut -d '"' -f 4)
    curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$latest_nvm_version/install.sh" | bash
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  fi

  # Verifica versões do Node.js
  current_node_version=$(nvm current 2>/dev/null)
  latest_lts_version=$(nvm version-remote --lts 2>/dev/null)

  if [ "$current_node_version" = "$latest_lts_version" ]; then
    echo "Node.js já está na versão LTS mais recente ($current_node_version)"
    return 0
  fi

  echo "Atualizando Node.js de ${current_node_version:-não instalado} para $latest_lts_version..."

  # Instala a última LTS
  nvm install --lts
  nvm use --lts
  nvm alias default lts/*

  # Instala dependências globais
  echo "Instalando dependências globais..."
  npm install -g neovim @github/copilot

  echo "Node.js atualizado para $latest_lts_version com sucesso!"
}

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"


export PATH=$PATH:~/go/bin:/usr/local/go/bin

. "$HOME/.local/bin/env"
