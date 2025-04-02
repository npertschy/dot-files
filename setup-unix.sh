echo "Setting up Unix environment"

echo "Setup WezTerm config"
ln -s -f ~/Projects/dot-files/.wezterm.lua ~/.wezterm.lua

echo "Setup zsh"
ln -s -f ~/Projects/dot-files/.zshrc ~/.zshrc

echo "Setup starship config"
if [ ! -d "$HOME/.config/" ]; then
	mkdir "$HOME/.config/"
fi

ln -s -f ~/Projects/dot-files/starship.toml ~/.config/starship.toml

echo "Setupu Neovim"
cp -rsf ~/Projects/dot-files/nvim/ ~/.config/nvim/
