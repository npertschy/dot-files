echo "Setting up Unix environment"

echo "Setup WezTerm config"
ln -s ~/Projects/dot-files/.wezterm.lua ~/.wezterm.lua

echo "Setup zsh"
ln -s ~/Projects/dot-files/.zshrc-mac ~/.zshrc

echo "Setup starship config"
if [ ! -d "$HOME/.config/" ]; then
	mkdir "$HOME/.config/"
fi

ln -s ~/Projects/dot-files/starship.toml ~/.config/starship.toml

echo "Setup Neovim"
rm -rf ~/.config/nvim
cp -rsf ~/Projects/dot-files/nvim/ ~/.config/nvim/
