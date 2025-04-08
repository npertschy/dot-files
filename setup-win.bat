echo "Setting up Windows environment"
echo "Setup WezTerm config"
mklink /H C:\Users\npertschy\.wezterm.lua wezterm.lua

echo "Setup powershell profile"
mkling /H C:\Users\npertschy\pwsh-keymap.json pwsh-keymap.json
mklink /H C:\Users\npertschy\pwsh-profile.ps1 pwsh-profile.ps1

echo "Setup starship config"
if not exist C:\Users\npertschy\.config\ (
	mkdir C:\Users\npertschy\.config\
)
mklink /H C:\Users\npertschy\.config\starship.toml starship.toml
