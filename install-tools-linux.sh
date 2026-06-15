#/bin/sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install starship

brew install fnm

fnm install 24

brew install fd

brew install ripgrep

brew install neovim

brew install git-delta

brew install eza

brew install zoxide
# for zoxide auto-completion
brew install fzf

brew install openjdk@21

brew install go

brew install tree-sitter-cli

brew install opencode

brew install uv

CC=gcc CXX=g++ uv tool install "vectorcode<1.0.0"

brew install zsh-syntax-highlighting
brew install zsh-autosuggestions
brew install zsh-completions
