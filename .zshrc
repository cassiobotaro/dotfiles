typeset -U path PATH fpath FPATH

# homebrew (Linux, Apple Silicon ou Intel)
for _brew in /home/linuxbrew/.linuxbrew/bin/brew /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [[ -x $_brew ]]; then
        eval "$($_brew shellenv)"
        fpath+=("$HOMEBREW_PREFIX/share/zsh/site-functions")
        break
    fi
done
unset _brew

# completions (auditoria de segurança só 1x/dia; rm o zcompdump pra forçar)
# kubectl/minikube vêm do site-functions do brew; gh do vendor-completions do apt
# nota: glob qualifiers não expandem dentro de [[ ]], daí o array auxiliar
autoload -Uz compinit
_zcd=(${ZDOTDIR:-$HOME}/.zcompdump(N.mh-24))
if (( $#_zcd )); then
    compinit -C
else
    compinit
fi
unset _zcd
# dump gerado por um zsh sem o fpath completo (sem o kubectl indexado)? reconstrói
if (( $+commands[kubectl] )) && (( ! $+_comps[kubectl] )); then
    rm -f ${ZDOTDIR:-$HOME}/.zcompdump
    compinit
fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case-insensitive

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt EXTENDED_HISTORY SHARE_HISTORY HIST_IGNORE_SPACE HIST_VERIFY
setopt HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS

setopt AUTO_CD NO_BEEP INTERACTIVE_COMMENTS

# keybindings
bindkey -e                                    # modo emacs
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search    # ↑ busca no histórico pelo prefixo
bindkey "^[[B" down-line-or-beginning-search  # ↓ idem
bindkey "^[[H" beginning-of-line              # Home
bindkey "^[OH" beginning-of-line              # Home (modo aplicação/iTerm)
bindkey "^[[F" end-of-line                    # End
bindkey "^[OF" end-of-line                    # End (modo aplicação/iTerm)
bindkey "^[[3~" delete-char                   # Delete
bindkey "^[[1;5C" forward-word                # Ctrl+→
bindkey "^[[1;5D" backward-word               # Ctrl+←
bindkey "^[[1;3C" forward-word                # Option+→ (iTerm)
bindkey "^[[1;3D" backward-word               # Option+← (iTerm)

export EDITOR="nvim"
export VISUAL="nvim"

# man pages com bat
if command -v bat >/dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export MANROFFOPT="-c"
fi

# aliases
alias cat="bat -p"
alias ls="eza"
alias ll="eza -lh --git"
alias la="eza -lah --git"
alias tree="eza --tree"
compdef eza=ls
alias zshconf="nvim ~/.zshrc"
alias zshreload="source ~/.zshrc"
alias nvimconf="nvim ~/.config/nvim/init.lua"
alias starshipconf="nvim ~/.config/starship.toml"
alias vim="nvim"
if [[ "$OSTYPE" == darwin* ]]; then
    alias sysup="brew update && brew upgrade && brew cleanup && sudo softwareupdate --install --all"
else
    alias sysup="sudo apt update && sudo apt upgrade -y && brew upgrade && sudo snap refresh"
fi
alias lzd="lazydocker"
alias dco="docker compose"

# git (mesmos do plugin git do oh-my-zsh)
alias g="git"
alias ga="git add"
alias gf="git fetch"
alias gl="git pull"
alias gp="git push"
alias gd="git diff"
alias gst="git status"
alias gc="git commit --verbose"
alias gsw="git switch"
alias gswc="git switch -c"
alias glog="git log --oneline --decorate --graph"
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"

# tmux: anexa a uma sessão (ta [nome]) ou cria uma nova (ts [nome])
function ta() { tmux attach ${1:+-t "$1"} }
function ts() { tmux new-session ${1:+-s "$1"} }

# alias k pro kubectl (completion vem do site-functions do brew)
if command -v kubectl >/dev/null; then
    alias k=kubectl
    compdef k=kubectl
fi

command -v fzf >/dev/null && source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'

# limpa caches do python (copiado do plugin python do oh-my-zsh)
function pyclean() {
  find "${@:-.}" -type f -name "*.py[co]" -delete
  find "${@:-.}" -type d -name "__pycache__" -delete
  find "${@:-.}" -depth -type d -name ".mypy_cache" -exec rm -r "{}" +
  find "${@:-.}" -depth -type d -name ".pytest_cache" -exec rm -r "{}" +
}

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
        -e STRUCTURIZR_THEMES=/usr/local/structurizr-themes \
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
    local current_version=$(go version 2>/dev/null | grep -oE 'go[0-9.]+' | head -n 1 | sed 's/go//')

    if [ -z "$current_version" ]; then
        echo "Go não encontrado. Instalando versão $latest_version..."
    elif [ "$current_version" = "$latest_version" ]; then
        echo "Go já está na versão mais recente ($current_version)"
        return 0
    else
        echo "Atualizando Go de $current_version para $latest_version..."
    fi

    local os=$(uname -s | tr '[:upper:]' '[:lower:]')  # linux | darwin
    local arch=$(uname -m)
    case "$arch" in
        x86_64) arch=amd64 ;;
        aarch64|arm64) arch=arm64 ;;
    esac
    curl -fsSLO "https://go.dev/dl/go${latest_version}.${os}-${arch}.tar.gz" && \
        sudo rm -rf /usr/local/go && \
        sudo tar -C /usr/local -xzf "go${latest_version}.${os}-${arch}.tar.gz"
    rm -f go*.tar.gz
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

# nvm (--no-use pula o "nvm use" do startup, ~500ms; a versão mais nova
# instalada entra no PATH direto via glob — sem subprocesso)
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    \. "$NVM_DIR/nvm.sh" --no-use
    _nvm_latest=("$NVM_DIR"/versions/node/*(N/nOn[1]))
    [ -n "$_nvm_latest" ] && PATH="$_nvm_latest/bin:$PATH"
    unset _nvm_latest
fi
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init - zsh)"


export PATH="$PATH:$HOME/go/bin:/usr/local/go/bin"
export PATH="$HOME/.local/bin:$PATH"

eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd)"
