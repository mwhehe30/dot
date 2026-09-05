#!/usr/bin/env bash

set -euo pipefail

# Wallpaper Picker using rofi + swww
# Selection is cached so it survives reboot.

CACHE_FILE="$HOME/.cache/hypr/current-wallpaper"
WALLPAPER_DIR="${1:-$HOME/Wallpapers}"

if [[ ! -d "$WALLPAPER_DIR" ]]; then
    notify-send "Wallpaper" "Directory not found: $WALLPAPER_DIR"
    exit 1
fi

mapfile -d '' WALLPAPERS < <(find "$WALLPAPER_DIR" -maxdepth 2 -type f \
    \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) -print0 2>/dev/null)

if [[ "${#WALLPAPERS[@]}" -eq 0 ]]; then
    notify-send "Wallpaper" "No images found in $WALLPAPER_DIR"
    exit 1
fi

SELECTED="$(printf '%s\n' "${WALLPAPERS[@]}" | rofi -dmenu -i -p "Wallpaper" -display-columns 1)"

if [[ -z "$SELECTED" ]]; then
    exit 0
fi

swww img "$SELECTED" --transition-type random --transition-duration 1.0

mkdir -p "$(dirname "$CACHE_FILE")"
printf '%s\n' "$SELECTED" > "$CACHE_FILE"

notify-send "Wallpaper" "$(basename "$SELECTED")"
