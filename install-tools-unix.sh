/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> /Users/Lina/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/Lina/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install starship

brew install node@22

brew install npm 

brew install fnm

brew install fd

brew install ripgrep

brew install neovim

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
