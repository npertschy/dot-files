#/bin/sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install starship

brew install fnm

fnm install 22

brew install fd

brew install ripgrep

brew install openjdk@21

brew install golang-go

brew install neovim

brew install git-delta

brew install eza

brew install zoxide
# for zoxide auto-completion
brew install fzf

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

brew install tree-sitter-cli

brew install opencode

brew install uv

CC=gcc CXX=g++ uv tool install "vectorcode<1.0.0"

brew install zsh-syntax-highlighting
brew install zsh-autosuggestions
