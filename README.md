# CachyOS Hyprland Config (Anti-Noctalia)

Hyprland configuration adapted from the [Aurora NixOS setup](../../) for **CachyOS**, replacing the default **Noctalia** shell with a clean, standalone, dependency-light Hyprland setup.

Includes: Hyprland Lua config, Rofi launcher, Mako notifications, Kitty terminal, Swww wallpaper manager — all themed with **Everforest** (calm green earthy dark theme).

## Install (one command)

```bash
git clone <your-repo-url> && cd NixOS/cachyos-hyprland
./install.sh
```

Requires a normal user with sudo. An AUR helper (`paru`/`yay`) is recommended — the script auto-detects it for `zen-browser`, `obsidian`, and `zed`. Install `paru` first if you want those.

The script will:
1. Install all packages (Hyprland, kitty, rofi, swww, mako, etc.)
2. Disable Noctalia / leftover shell services
3. Back up your existing `~/.config/{hypr,kitty,rofi,mako,noctalia}`
4. Deploy the new configs
5. Make all scripts executable

After install, log out and select the **Hyprland** session (UWSM or plain). Then edit `~/.config/hypr/config/monitor.lua` to match your display(s) (`hyprctl monitors`).

## Keybinds (SUPER = Windows key)

| Keys | Action |
|---|---|
| `SUPER + Return` | Terminal |
| `SUPER + A` | App launcher (rofi) |
| `SUPER + Q` | Close window |
| `SUPER + D` | Maximize |
| `SUPER + F` | Float toggle |
| `SUPER + B` | Browser |
| `SUPER + E` | File manager |
| `SUPER + Z` | GUI editor |
| `SUPER + N` | Obsidian |
| `SUPER + T` | Neovim |
| `SUPER + V` | Clipboard (rofi) |
| `SUPER + I` | Emoji picker (rofi) |
| `SUPER + P` | Wallpaper picker |
| `SUPER + SHIFT + S` | Screenshot region (grim+swappy) |
| `Print` | Full screenshot |
| `SUPER + H/J/K/L` | Move focus |
| `SUPER + SHIFT + H/J/K/L` | Move window |
| `SUPER + CTRL + H/J/K/L` | Resize window |
| `SUPER + 1-0` | Switch workspace |
| `SUPER + SHIFT + 1-0` | Move window to workspace |
| `SUPER + S` | Scratchpad |
| `SUPER + SHIFT + L` | Lock screen (hyprlock) |
| Media keys | Volume / brightness / playback |

## Structure

```
cachyos-hyprland/
├── install.sh                  # One-command installer
├── hypr/
│   ├── hyprland.lua            # Lua entry point
│   └── config/                 # Split Lua configs (same layout as NixOS Aurora)
│   └── scripts/                # wallpaper picker + restore
├── kitty/kitty.conf            # Everforest terminal
├── rofi/config.rasi            # Rofi launcher theme
└── mako/config                # Notification daemon theme
```

## Notes

- Config uses Hyprland's native **Lua** config format (`hl.*` API), same as CachyOS v2 dots.
- The theme is Everforest (calm green earthy). To switch themes, edit `hypr/config/theme.lua` (colors), `general.lua`/`decoration.lua` (radius/opacity), and `kitty.conf` (ANSI colors).
- Wallpapers live in `~/Wallpapers`. `SUPER + P` picks one; the last one is restored on login.
- NVIDIA users: uncomment the environment block in `hypr/config/env.lua`.