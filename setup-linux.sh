#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${HOME}/Projects/dot-files"
source "${DOTFILES_DIR}/symlinker.sh"

declare -A FILE_LINKS=(
    ["${DOTFILES_DIR}/lazygit.yml"]="${HOME}/.config/lazygit/config.yml"
    ["${DOTFILES_DIR}/shell-sequences-setup.sh"]="${HOME}/shell-sequences-setup.sh"
    ["${DOTFILES_DIR}/linux/.gitconfig"]="${HOME}/.gitconfig"
    ["${DOTFILES_DIR}/linux/.zshrc"]="${HOME}/.zshrc"
    ["${DOTFILES_DIR}/starship.toml"]="${HOME}/.config/starship.toml"
)

declare -A DIR_LINKS=(
    ["${DOTFILES_DIR}/nvim"]="${HOME}/.config/nvim"
)

for src in "${!FILE_LINKS[@]}"; do
    link_target "$src" "${FILE_LINKS[$src]}"
done

for src in "${!DIR_LINKS[@]}"; do
    link_target "$src" "${DIR_LINKS[$src]}"
done
