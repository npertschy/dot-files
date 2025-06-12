#/bin/sh

echo "Setting up Unix environment"

echo "Setup zsh"
ln -s -f ~/Projects/dot-files/.zshrc-linux ~/.zshrc

echo "Setup starship config"
if [ ! -d "$HOME/.config/" ]; then
	mkdir "$HOME/.config/"
fi

ln -s -f ~/Projects/dot-files/starship.toml ~/.config/starship.toml

echo "Setup Neovim"
cp -l -r -f ~/Projects/dot-files/nvim/ ~/.config/nvim/
