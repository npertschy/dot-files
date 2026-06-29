link_target() {
    local src="$1"
    local dst="$2"

    # Zielverzeichnis anlegen falls nötig
    local dst_dir
    dst_dir="$(dirname "$dst")"
    if [[ ! -d "$dst_dir" ]]; then
        echo "Creating directory: $dst_dir"
        mkdir -p "$dst_dir"
    fi

    if [[ -L "$dst" ]]; then
        echo "Removing existing symlink: $dst"
        rm "$dst"
    elif [[ -d "$dst" ]]; then
        echo "Backing up directory: $dst -> ${dst}.bak"
        mv "$dst" "${dst}.bak"
    elif [[ -e "$dst" ]]; then
        echo "Backing up file: $dst -> ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi

    echo "Linking: $src -> $dst"
    ln -s "$src" "$dst"
}
