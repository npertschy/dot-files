#/bin/sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

brew install starship

brew install fnm

fnm install 22

brew install fd

brew install ripgrep

brew install openjdk@21

brew install golang-go

brew install neovim

brew install git-delta

brew install bat

brew install fzf

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

npm i -g tree-sitter-cli

brew install opencode
