#/bin/sh

echo "Setting up Unix environment"

echo "Setup zsh"
ln -s ~/Projects/dot-files/.zshrc-linux ~/.zshrc

echo "Setup starship config"
if [ ! -d "$HOME/.config/" ]; then
	mkdir "$HOME/.config/"
fi

ln -s ~/Projects/dot-files/starship.toml ~/.config/starship.toml

echo "Setup Neovim"
rm -rf ~/.config/nvim
cp -rsf ~/Projects/dot-files/nvim/ ~/.config/nvim/

echo "Setup k9s"
sudo ln -s /opt/k9s /usr/local/bin/k9s
