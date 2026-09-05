-- Theme
-- Standalone CachyOS Hyprland
-- Everforest (Calm green earthy dark theme)

-- Color Helpers

local function stripHash(color)
	if color == nil then
		return "000000"
	end

	return color:gsub("^#", "")
end

-- Convert #RRGGBB -> rgba(RRGGBBAA)

local function rgba(color, alpha)
	return "rgba(" .. stripHash(color) .. alpha .. ")"
end

-- Everforest palette

local colors = {
	background     = "#2D353B",
	backgroundDark = "#232A2E",
	surface        = "#343F44",
	surfaceHover   = "#3D484D",
	surfaceActive  = "#475258",
	border         = "#4A575D",
	borderFocus    = "#A7C080",
	separator      = "#414B50",
	text           = "#D3C6AA",
	textSecondary  = "#9DA9A0",
	textMuted      = "#859289",
	accent         = "#A7C080",
	accentHover    = "#83C092",
	accentActive   = "#D699B6",
	accentMuted    = "#475258",
	success        = "#A7C080",
	warning        = "#DBBC7F",
	error          = "#E67E80",
	info           = "#7FBBB3",
}

-- Window border colors

hl.config({

	general = {

		col = {

			-- Active Window Border

			active_border = {

				colors = {

					rgba(colors.accent, "ff"),

					rgba(colors.info, "ff"),
				},

				angle = 45,
			},

			-- Inactive Window Border

			inactive_border = rgba(colors.border, "cc"),
		},
	},
})
