echo "Setting up Unix environment"
echo "Setup WezTerm config"
ln .wezterm.lua "$HOME/.wezterm.lua" 

ln .zshrc "$HOME/.zshrc"

echo "Setup starship config"
if [ ! -d "$HOME/.config/" ]; then
	mkdir "$HOME/.config/"
fi

ln starship.toml "$HOME/.config/starship.toml"

cp -Rl nvim "$HOME/.config/nvim/"
