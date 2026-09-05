-- Decoration
-- Standalone CachyOS Hyprland

hl.config({

	decoration = {

		-- dim_inactive is off on purpose: inactive_opacity below already signals focus.
		dim_inactive = false,
		dim_around = 0.30,
		dim_special = 0.20,
		dim_strength = 0.1,

		-- Rounded Corners

		rounding = 10,

		rounding_power = 2,

		-- Window Opacity

		active_opacity = 1.0,

		inactive_opacity = 0.96,

		-- Shadows

		shadow = {
			enabled = true,
			range = 18,
			render_power = 4,
			sharp = false,
			color = "rgba(00000033)",
		},

		-- Blur

		blur = {
			enabled = true,
			size = 8,
			passes = 3,
			vibrancy = 0.18,
			vibrancy_darkness = 0.0,
			brightness = 1.0,
			contrast = 1.8,
			noise = 0.01,
			popups = true,
			special = 0,
			new_optimizations = true,
			ignore_opacity = true,
			xray = true,
		},
	},
})
