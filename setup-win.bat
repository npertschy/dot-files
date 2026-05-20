echo "Setting up Windows environment"
echo "Setup WezTerm config"
cmd /c mklink C:\Users\npertschy\.wezterm.lua C:\Users\npertschy\Projects\dot-files\.wezterm.lua

echo "Setup powershell profile"
cmd /c mklink C:\Users\npertschy\pwsh-keymap.json C:\Users\npertschy\Projects\dot-files\pwsh-keymap.json
cmd /c mklink C:\Users\npertschy\pwsh-profile.ps1 C:\Users\npertschy\Projects\dot-files\pwsh-profile.ps1

echo "Setup starship config"
if not exist C:\Users\npertschy\.config\ (
	cmd /c mkdir C:\Users\npertschy\.config\
)
cmd /c mklink C:\Users\npertschy\.config\starship.toml C:\Users\npertschy\Projects\dot-files\starship.toml
