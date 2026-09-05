#!/usr/bin/env bash
#
# CachyOS Hyprland installer (Anti-Noctalia)
# Single-command setup for the Aurora-derived Hyprland config
#
# Usage:  ./install.sh
#         sudo ./install.sh   (if not a sudoer via non-interactive)
#
# What this does:
#   1. Installs required packages (Hyprland, kitty, rofi, swww, mako, etc.)
#   2. Disables / removes the Noctalia shell dependency
#   3. Backs up existing ~/.config/hypr (and related)
#   4. Deploys all configs (hypr, kitty, rofi, mako)
#   5. Makes scripts executable
#   6. Prints a summary + next steps

set -euo pipefail

# ---------- Colours ----------

BOLD="\033[1m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
RESET="\033[0m"

info()  { echo -e "${CYAN}${BOLD}[INFO]${RESET} $*"; }
ok()    { echo -e "${GREEN}${BOLD}[ OK ]${RESET} $*"; }
warn()  { echo -e "${YELLOW}${BOLD}[WARN]${RESET} $*"; }
err()   { echo -e "${RED}${BOLD}[FAIL]${RESET} $*" >&2; }

die()   { err "$*"; exit 1; }

# ---------- Script location ----------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---------- Detect package manager ----------

detect_aur_helper() {
    for helper in paru yay; do
        if command -v "$helper" >/dev/null 2>&1; then
            echo "$helper"
            return 0
        fi
    done
    return 1
}

AUR_HELPER="$(detect_aur_helper || true)"
if [[ -z "$AUR_HELPER" ]]; then
    warn "No AUR helper detected (paru/yay). Some packages may be missing from official repos."
    warn "Install paru first:  sudo pacman -S --needed base-devel && git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si"
    warn "Continuing with pacman only (best-effort)..."
fi

# ---------- Root check ----------

if [[ "$(id -u)" -eq 0 ]]; then
    die "Do NOT run as root. Run as a normal user with sudo privileges."
fi

# ---------- Preference ----------

USE_UWSM=false
if command -v uwsm >/dev/null 2>&1; then
    USE_UWSM=true
fi

# ---------- Packages ----------

REPO_PKGS=(
    hyprland
    kitty
    rofi
    swww
    grim
    slurp
    swappy
    wl-clipboard
    cliphist
    wtype
    brightnessctl
    playerctl
    mako
    waybar
    network-manager-applet
    blueman
    polkit-gnome
    pavucontrol
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    qt6ct
    kvantum
    nwg-look
    papirus-icon-theme
    ttf-jetbrains-mono-nerd
    lxappearance
    hyprlock
    hypridle
    neovim
)

# Apps from the NixOS config (install via official repos where available)
APP_PKGS=(
    helium-browser-bin       # CachyOS repos (stable)
    thunar
    gwenview
    file-roller
    vlc
)

install_packages() {
    info "Installing packages..."

    if [[ -n "$AUR_HELPER" ]]; then
        info "Using AUR helper: $AUR_HELPER"

        local exist=()
        local missing=()
        for pkg in "${REPO_PKGS[@]}" "${APP_PKGS[@]}"; do
            if pacman -Q "$pkg" >/dev/null 2>&1; then
                exist+=("$pkg")
            else
                missing+=("$pkg")
            fi
        done

        if [[ "${#missing[@]}" -gt 0 ]]; then
            info "Installing ${#missing[@]} package(s): ${missing[*]}"
            "$AUR_HELPER" -S --needed --noconfirm "${missing[@]}"
        else
            ok "All packages already installed."
        fi
    else
        # pacman only: install repo packages that are missing
        local to_install=()
        for pkg in "${REPO_PKGS[@]}"; do
            if ! pacman -Q "$pkg" >/dev/null 2>&1; then
                to_install+=("$pkg")
            fi
        done
        if [[ "${#to_install[@]}" -gt 0 ]]; then
            info "Installing repo packages (pacman): ${to_install[*]}"
            sudo pacman -S --needed --noconfirm "${to_install[@]}"
        else
            ok "All repo packages already installed."
        fi
        warn "helium-browser-bin not installed - no AUR helper detected (install paru first)."
    fi
}

# ---------- Disable Noctalia / old shell ----------

disable_noctalia() {
    info "Disabling Noctalia / old shell services..."
    local -a units=(
        "noctalia.service"
        "noctalia-greeter.service"
    )
    for u in "${units[@]}"; do
        if systemctl list-unit-files --user | grep -q "$u" 2>/dev/null; then
            systemctl --user disable --now "$u" 2>/dev/null || true
        fi
        if systemctl list-unit-files --system | grep -q "$u" 2>/dev/null; then
            sudo systemctl disable --now "$u" 2>/dev/null || true
        fi
    done
    ok "Noctalia disabled (if present)."
}

# ---------- Backups ----------

backup_existing() {
    local ts
    ts="$(date +%Y%m%d-%H%M%S)"
    local backup_dir="$HOME/.config/backups/cachyos-hyprland-$ts"
    mkdir -p "$backup_dir"
    info "Backing up existing configs to: $backup_dir"

    for d in hypr kitty rofi mako waybar; do
        if [[ -e "$HOME/.config/$d" ]]; then
            cp -r "$HOME/.config/$d" "$backup_dir/" 2>/dev/null || true
        fi
    done

    # Also save current Noctalia config so it's recoverable
    if [[ -e "$HOME/.config/noctalia" ]]; then
        cp -r "$HOME/.config/noctalia" "$backup_dir/" 2>/dev/null || true
    fi

    ok "Backup complete."
    echo "$backup_dir" > /tmp/cachyos-backup-dir.txt
}

# ---------- Deploy configs ----------

deploy_configs() {
    info "Deploying Hyprland config..."

    mkdir -p "$HOME/.config/hypr"

    # Clear old aurora leftovers
    rm -rf "$HOME/.config/hypr/config" 2>/dev/null || true

    # Copy new config
    cp -r "$SCRIPT_DIR/hypr/hyprland.lua" "$HOME/.config/hypr/hyprland.lua"
    cp -r "$SCRIPT_DIR/hypr/config"        "$HOME/.config/hypr/config"
    cp -r "$SCRIPT_DIR/hypr/scripts"       "$HOME/.config/hypr/scripts"

    # kitty
    info "Deploying kitty config..."
    mkdir -p "$HOME/.config/kitty"
    cp -r "$SCRIPT_DIR/kitty/kitty.conf"   "$HOME/.config/kitty/kitty.conf"

    # rofi
    info "Deploying rofi config..."
    mkdir -p "$HOME/.config/rofi"
    cp -r "$SCRIPT_DIR/rofi/config.rasi"   "$HOME/.config/rofi/config.rasi"

    # mako
    info "Deploying mako config..."
    mkdir -p "$HOME/.config/mako"
    cp -r "$SCRIPT_DIR/mako/config"        "$HOME/.config/mako/config"

    # waybar
    info "Deploying waybar config..."
    mkdir -p "$HOME/.config/waybar"
    cp -r "$SCRIPT_DIR/waybar/config.jsonc" "$HOME/.config/waybar/config.jsonc"
    cp -r "$SCRIPT_DIR/waybar/style.css"    "$HOME/.config/waybar/style.css"

    # Mark scripts executable
    chmod +x "$HOME/.config/hypr/scripts/"*.sh

    ok "Configs deployed."
}

# ---------- Wallpapers dir ----------

ensure_wallpapers() {
    if [[ ! -d "$HOME/Wallpapers" ]]; then
        mkdir -p "$HOME/Wallpapers"
        warn "Created ~/Wallpapers - drop your wallpapers here."
    fi
}

# ---------- Optional: set UWSM as session ----------

configure_uwsm() {
    if command -v uwsm >/dev/null 2>&1; then
        info "UWSM detected. Adding required env exports..."
        mkdir -p "$HOME/.config/uwsm"
        if [[ ! -f "$HOME/.config/uwsm/env" ]]; then
            cat > "$HOME/.config/uwsm/env" <<'EOF'
# UWSM environment
QT_QPA_PLATFORMTHEME=qt6ct
QT_WAYLAND_DISABLE_WINDOWDECORATION=1
ELECTRON_OZONE_PLATFORM_HINT=auto
XDG_CURRENT_DESKTOP=Hyprland
XDG_SESSION_DESKTOP=Hyprland
EOF
            ok "UWSM env written."
        fi
    fi
}

# ---------- Final check ----------

verify() {
    info "Verifying installation..."
    # Hyprland Lua syntax is validated by hyprctl at launch; just check files exist.
    if [[ -f "$HOME/.config/hypr/hyprland.lua" ]]; then
        ok "Hyprland config present."
    else
        err "Hyprland config missing!"
    fi
}

# ---------- Main ----------

main() {
    echo
    info "   CachyOS Hyprland Installer (Anti-Noctalia)"
    echo

    install_packages
    disable_noctalia
    backup_existing
    deploy_configs
    ensure_wallpapers
    configure_uwsm
    verify

    echo
    ok "Installation complete!"
    echo
    echo -e "${BOLD}Next steps:${RESET}"
    echo -e "  1. ${CYAN}Edit ~/.config/hypr/config/monitor.lua${RESET} to match your display(s)."
    echo -e "  2. Log out and select the ${BOLD}Hyprland${RESET} session (UWSM or plain Hyprland)."
    echo -e "  3. Drop wallpapers into ${BOLD}~/Wallpapers${RESET}."
    echo
    echo -e "  ${BOLD}Keybinds (SUPER = Windows key):${RESET}"
    echo -e "    SUPER + Return  terminal          SUPER + Q  close window"
    echo -e "    SUPER + A       app launcher (rofi)"
    echo -e "    SUPER + E       file manager      SUPER + B  browser"
    echo -e "    SUPER + V       clipboard (rofi)  SUPER + I  emoji"
    echo -e "    SUPER + P       wallpaper picker"
    echo -e "    SUPER + SHIFT+S screenshot (grim)  SUPER+F float"
    echo -e "    SUPER ± 1-10    workspaces        SUPER+S scratchpad"
    echo -e "    SUPER + H/J/K/L focus             SUPER+CTRL+H/J/K/L resize"
    echo
    echo -e "  Backup saved at: $(cat /tmp/cachyos-backup-dir.txt 2>/dev/null || echo 'N/A')"
    echo
}

main "$@"
