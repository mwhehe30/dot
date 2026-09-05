-- Keybindings
-- Standalone CachyOS Hyprland (no Quickshell / Noctalia)

-- Import Variables

local vars = require("config.variables")
local mainMod = vars.mainMod
local altMod = vars.altMod

-- Applications

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(vars.terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(vars.fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(vars.browser))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(vars.menu))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(vars.guieditor))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(vars.note))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(vars.editor))

-- Window Management

hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.window.center())

-- Lock Screen

hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))

-- Screenshot

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(vars.screenshot))
hl.bind("Print", hl.dsp.exec_cmd("grim - | wl-copy"))

-- Wallpaper

hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(vars.wallpaper))

-- Clipboard

hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(vars.clipboard))

-- Emoji

hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(vars.emoji))

-- Focus Movement (vim style)

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Move window in a direction

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Resize windows

hl.bind(mainMod .. " + CONTROL + H", hl.dsp.window.resize({ x = -45, y = 0, relative = true }))
hl.bind(mainMod .. " + CONTROL + J", hl.dsp.window.resize({ x = 0, y = 45, relative = true }))
hl.bind(mainMod .. " + CONTROL + K", hl.dsp.window.resize({ x = 0, y = -45, relative = true }))
hl.bind(mainMod .. " + CONTROL + L", hl.dsp.window.resize({ x = 45, y = 0, relative = true }))

-- Workspaces

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Relative workspace navigation

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + CONTROL + Right", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + CONTROL + Left", hl.dsp.focus({ workspace = "m-1" }))

-- Special workspace (scratchpad)

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))

-- Mouse

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Audio

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(vars.volumeUp), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(vars.volumeDown), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(vars.volumeMute), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(vars.micMute), { locked = true, repeating = true })

-- Brightness

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(vars.brightnessUp), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(vars.brightnessDown), { locked = true, repeating = true })

-- Media

hl.bind("XF86AudioNext", hl.dsp.exec_cmd(vars.mediaNext), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(vars.mediaPrev), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(vars.mediaPlay), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(vars.mediaPlay), { locked = true })

-- App launcher / power menu

hl.bind(altMod .. " + F2", hl.dsp.exec_cmd("rofi -show drun -modes drun,run"))
