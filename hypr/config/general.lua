-- General Configuration
-- Standalone CachyOS Hyprland

-- Theme values (Everforest)
local radius = 10
local borderWidth = 2
local windowOpacity = 0.96

hl.config({

	general = {

		gaps_in = 5,

		gaps_out = 10,

		-- Borders

		border_size = borderWidth,

		-- Resize

		resize_on_border = true,

		-- Tearing

		allow_tearing = false,

		-- Layout

		layout = "dwindle",
	},
})
