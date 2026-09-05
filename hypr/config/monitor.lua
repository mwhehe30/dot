-- Monitor Configuration
-- Standalone CachyOS Hyprland
-- Run `hyprctl monitors` to find your outputs. Edit to match your setup.

-- Primary Display (laptop panel - example)

hl.monitor({
	output = "eDP-1",
--	mode = "1920x1080@60.00800",
--	position = "0x0",
--	scale = 1.25,
    disabled = true
})

-- External Monitor

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@180.00301",
	--position = "1920x0",
	position = "0x0",
	scale = 1,
})
