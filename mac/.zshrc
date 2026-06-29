# Homebrew
BREW_PREFIX="/home/linuxbrew/.linuxbrew"
eval "$($BREW_PREFIX/bin/brew shellenv)"

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# PATH
typeset -U PATH

export PATH="$HOME/.local/bin:$PATH"
export JAVA_HOME="$BREW_PREFIX/opt/openjdk@21/libexec"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Completion
fpath=($BREW_PREFIX/share/zsh-completions $fpath)

autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Tools
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"

# Plugins
source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliase
alias ls="eza --icons"
alias ll="eza -lhg --git"
alias la="eza -lhga --git"
compdef eza=ls

