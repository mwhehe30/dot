-- Variables
-- Standalone CachyOS Hyprland (no Quickshell / Noctalia)

local M = {}

-- Modifier Key

M.mainMod = "SUPER"
M.altMod = "ALT"

-- Applications

M.terminal = "kitty"

M.browser = "helium-browser"

M.fileManager = "thunar"

M.editor = "nvim"

M.guieditor = "kitty -e nvim"

M.note = "kitty -e nvim"

-- Rofi Launcher

M.menu = "rofi -show drun"

M.emoji = "rofi -show emoji"

-- Clipboard (cliphist)

M.clipboard = "cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"

-- Screenshot

M.screenshot = "grim -g \"$(slurp)\" - | swappy -f -"

-- Wallpaper Picker (swww)

M.wallpaper = "~/.config/hypr/scripts/wallpaper-picker.sh"

-- Colorscheme (placeholder - uses fixed theme)

M.colorscheme = "~/.config/hypr/scripts/theme-switch.sh"

-- Scripts Directory

M.scriptDir = os.getenv("HOME") .. "/.config/hypr/scripts"

-- Wallpapers

M.wallpaperDir = os.getenv("HOME") .. "/Wallpapers"

-- Audio

M.volumeUp = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"

M.volumeDown = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

M.volumeMute = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

M.micMute = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

-- Brightness

M.brightnessUp = "brightnessctl -e4 -n2 set 5%+"

M.brightnessDown = "brightnessctl -e4 -n2 set 5%-"

-- Media

M.mediaPlay = "playerctl play-pause"

M.mediaNext = "playerctl next"

M.mediaPrev = "playerctl previous"

-- WiFi / Bluetooth toggle helpers

M.wifiMenu = "nm-connection-editor"

return M
