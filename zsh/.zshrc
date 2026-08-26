# ~/.zshrc

export EDITOR=emacs\ -nw
export SUDO_EDITOR=emacs\ -nw

path+=(
"$HOME/.dotnet/tools"
"$HOME/.cargo/bin"
)

eval "$(zoxide init zsh)"

setopt autocd
setopt extendedglob
setopt interactivecomments

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY
setopt HIST_VERIFY

autoload -Uz compinit
compinit

eval "$(dircolors -b)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list \
    'm:{a-z}={A-Za-z}' \
    'r:|=*' \
    'l:|=* r:|=*'

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

alias lg='lazygit'
alias se='sudoedit'
alias pyenv='source $HOME/pyenv/bin/activate'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

alias ll='ls -lh'
alias la='ls -A'
alias lla='ls -lAh'

alias fceux='gamescope -f -- fceux'

mkcd() {
mkdir -p "$1" && cd "$1"
}

autoload -Uz colors
colors

PROMPT='%F{cyan}[%*]%f %F{green}%n@%m%f %F{blue}%~%f '

saveshot() {
    mkdir -p "$HOME/Pictures/Screenshots"
    wl-paste --type image/png \
        > "$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
}

# NPM global bin (added by Qwen Code installer)
export PATH="$HOME/.npm-global/bin:$PATH"

# opencode
export PATH=/home/jan/.opencode/bin:$PATH
