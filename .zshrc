typeset -U path PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="steeef"

plugins=(
    brew
    git
    fzf
    extract
    tmux
    sudo
    gh
    docker-compose
    kubectl
    minikube
    python
    eza
    uv
    nvm
)

zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:nvm' lazy-cmd nvim node npm npx

ZSH_DISABLE_COMPFIX=true
source "$ZSH/oh-my-zsh.sh"
export EDITOR='nvim'

setopt HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS

# aliases
alias cat="bat -p"
alias tree="eza --tree"
alias zshconf="nvim ~/.zshrc"
alias zshreload="source ~/.zshrc"
alias nvimconf="nvim ~/.config/nvim/init.lua"
alias vim="nvim"
alias sysup="sudo apt update && sudo apt upgrade -y && brew upgrade && sudo snap refresh"
alias lzd="lazydocker"

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'

# structurizr
function c4_local() {
    docker run --rm -it \
        -p 8080:8080 \
        -u $(id -u):$(id -g) \
        -v "$PWD":/usr/local/structurizr/ \
        -e STRUCTURIZR_AUTOREFRESHINTERVAL=2000 \
        -e STRUCTURIZR_AUTOSAVEINTERVAL=5000 \
        -e STRUCTURIZR_THEMES=/usr/local/structurizr-themes \
        structurizr/structurizr local
}

# structurizr export
function c4_export(){
    local format=${1:?"The format must be specified."}
    docker run --rm -it \
        -u $(id -u):$(id -g) \
        -v "$PWD":/usr/local/structurizr/ \
        structurizr/structurizr export -workspace workspace.json -format "${format}" -output diagrams
}

# structurizr playground
function c4_play() {
    docker run --rm -it \
        -p 8081:8081 \
        -e PORT=8081 \
        -e STRUCTURIZR_THEMES=/usr/local/structurizr-themes \
        structurizr/structurizr playground
}

# structurizr mcp
function c4_mcp() {
    docker run --rm -it \
        -p 3000:3000 \
        -e PORT=3000 \
        -e STRUCTURIZR_THEMES=/usr/local/structurizr-themes \
        structurizr/mcp \
        -dsl -mermaid -plantuml
}

function c4_update() {
    docker pull structurizr/structurizr && \
    docker pull structurizr/mcp
}

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
    local latest_version=$(pyenv latest -k 3)
    local current_version=$(pyenv global 2>/dev/null)

    if [ "$current_version" = "$latest_version" ]; then
        echo "Python já está na versão mais recente ($current_version)"
        return 0
    else
        echo "Atualizando Python de $current_version para $latest_version..."
    fi

    pyenv install -s "$latest_version"
    pyenv global "$latest_version"
    pyenv rehash
}

function uggo(){
    local latest_version=$(curl -sSL 'https://go.dev/dl/?mode=json' | jq -r '.[0].version' | sed 's/go//')
    local current_version=$(go version 2>/dev/null | grep -oP 'go[0-9.]+' | head -n 1 | sed 's/go//')

    if [ -z "$current_version" ]; then
        echo "Go não encontrado. Instalando versão $latest_version..."
    elif [ "$current_version" = "$latest_version" ]; then
        echo "Go já está na versão mais recente ($current_version)"
        return 0
    else
        echo "Atualizando Go de $current_version para $latest_version..."
    fi

    local arch=$(dpkg --print-architecture)
    wget "https://go.dev/dl/go${latest_version}.linux-${arch}.tar.gz" && \
        sudo rm -rf /usr/local/go && \
        sudo tar -C /usr/local -xzf "go${latest_version}.linux-${arch}.tar.gz"
    rm -f go*.linux-*.tar.gz
}

function ugjs(){
    if ! command -v nvm >/dev/null 2>&1; then
        echo "NVM não encontrado. Instalando..."
        local latest_nvm_version=$(curl -sSL https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep tag_name | cut -d '"' -f 4)
        curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$latest_nvm_version/install.sh" | bash
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    fi

    # Verifica versões do Node.js
    local current_node_version=$(nvm current 2>/dev/null)
    local latest_lts_version=$(nvm version-remote --lts 2>/dev/null)

    if [ -n "$current_node_version" ] && [ "$current_node_version" != "none" ] && [ "$current_node_version" = "$latest_lts_version" ]; then
        echo "Node.js já está na versão LTS mais recente ($current_node_version)"
        return 0
    fi

    echo "Atualizando Node.js de ${current_node_version:-não instalado} para $latest_lts_version..."

    # Instala a última LTS
    nvm install --lts
    nvm use --lts

    # Instala dependências globais
    echo "Instalando dependências globais..."
    npm install -g neovim @github/copilot tree-sitter-cli

    echo "Node.js atualizado para $latest_lts_version com sucesso!"
}

function ujs(){
    npm update -g npm neovim tree-sitter-cli
    copilot update
    nvm use --lts
}

function upy(){
    python -m ensurepip
    pyenv rehash
    python -m pip install -U pip
    python -m pip install -U wheel ruff neovim httpie
    uv self update
}

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT ]] && path=("$PYENV_ROOT/bin" "$PYENV_ROOT/shims" $path)
pyenv() {
    unfunction pyenv
    eval "$(command pyenv init - zsh)"
    pyenv "$@"
}


export PATH="$PATH:$HOME/go/bin:/usr/local/go/bin"
export PATH="$HOME/.local/bin:$PATH"

eval "$(zoxide init zsh --cmd cd)"
