#/bin/sh

apt install starship

curl -fsSL https://fnm.vercel.app/install | bash

fnm install 22

apt install npm

apt install fd-find

# apt install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

curl -LO https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz
sudo tar -C /opt -xzf jdk-21_linux-x64_bin.tar.gz
