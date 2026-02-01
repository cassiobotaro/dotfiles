# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="steeef"

plugins=(
    brew
    git
    fzf
    extract
    zoxide
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

source $ZSH/oh-my-zsh.sh
export EDITOR='nvim'

# aliases
alias cat="bat -p"
alias tree="ls -T"
alias zshconf="nvim ~/.zshrc"
alias nvimconf="nvim ~/.config/nvim/init.lua"
alias vim="nvim"
alias sysup="sudo apt update && sudo apt upgrade -y && brew upgrade && flatpak update -y"
alias lzd="lazydocker"
alias cd=z

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# structurizr
function structurizr() {
    docker run --rm -it \
        -p 8080:8080 \
        -u $(id -u ${USER}):$(id -g ${USER}) \
        -v "$PWD":/usr/local/structurizr/ \
        -e STRUCTURIZR_AUTOREFRESHINTERVAL=2000 \
        -e STRUCTURIZR_AUTOSAVEINTERVAL=5000 \
        structurizr/structurizr local
}

# structurizr export
function export_c4(){
    readonly format=${1:?"The format must be specified."}
    docker run --rm -it \
        -u $(id -u ${USER}):$(id -g ${USER}) \
        -v "$PWD":/usr/local/structurizr/ \
        structurizr/structurizr export -workspace workspace.json -format ${format} -output diagrams
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
  npm update -g npm neovim @github/copilot tree-sitter-cli
}

function upy(){
    python -m ensurepip
    pyenv rehash
    python -m pip install -U pip
    python -m pip install -U poetry wheel ruff neovim httpie
    uv self update
}

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"


export PATH=$PATH:~/go/bin:/usr/local/go/bin
. "$HOME/.local/bin/env"
