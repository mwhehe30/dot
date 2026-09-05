-- Layer Rules
-- Standalone CachyOS Hyprland

-- Wallpaper

hl.layer_rule({
	name = "wallpaper",

	match = {
		namespace = "^(swww|swww-daemon|wallpaper)$",
	},

	blur = false,

	order = 1,
})

-- Mako Notifications

hl.layer_rule({
	name = "notifications",

	match = {
		namespace = "^(mako|swaync)$",
	},

	blur = true,

	blur_popups = true,

	ignore_alpha = 0.20,

	order = 8,
})

-- Rofi

hl.layer_rule({
	name = "rofi",

	match = {
		namespace = "^rofi$",
	},

	blur = true,

	blur_popups = true,

	ignore_alpha = 0.20,

	order = 10,
})

-- Screen Capture and Colour Picking

hl.layer_rule({
	name = "screen-capture",

	match = {
		namespace = "^(selection|slurp|grim|hyprpicker|swappy)$",
	},

	blur = false,

	xray = true,

	order = 15,
})
