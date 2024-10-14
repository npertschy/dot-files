echo "Setting up Windows environment"
echo "Setup WezTerm config"
mklink /H C:\Users\npertschy\.wezterm.lua wezterm.lua

echo "Setup bash config"
mklink /H C:\Users\npertschy\.inputrc .inputrc
mklink /H C:\Users\npertschy\.bashrc .bashrc
mklink /H C:\Users\npertschy\.bash_profile .bash_profile

echo "Setup starship config"
if not exist C:\Users\npertschy\.config\ (
	mkdir C:\Users\npertschy\.config\
)
mklink /H C:\Users\npertschy\.config\starship.toml starship.toml
