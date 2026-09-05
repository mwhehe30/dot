#!/usr/bin/env bash

set -euo pipefail

# Wallpaper Restore (swww-based)

CACHE_FILE="$HOME/.cache/hypr/current-wallpaper"

# Nothing to restore

if [[ ! -f "$CACHE_FILE" ]]; then
    if command -v swww >/dev/null 2>&1; then
        # Fallback to a default wallpaper if ~/Wallpapers has one
        default_dir="${HOME}/Wallpapers"
        pick="$(find "${default_dir}" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) 2>/dev/null | head -n1)"
        if [[ -n "${pick:-}" ]]; then
            swww img "${pick}" --transition-type none >/dev/null 2>&1 || true
        fi
    fi
    exit 0
fi

WALLPAPER="$(cat "$CACHE_FILE")"

# Wallpaper was removed

if [[ ! -f "$WALLPAPER" ]]; then
    exit 0
fi

# Give the Wayland session / swww daemon a moment

sleep 1

# Restore wallpaper

swww img "$WALLPAPER" \
    --transition-type none \
    >/dev/null 2>&1 || true
