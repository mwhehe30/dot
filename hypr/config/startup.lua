-- Startup / Autostart
-- Standalone CachyOS Hyprland

hl.on("hyprland.start", function()
	-- Session Environment (best effort; UWSM may handle this already)

	hl.exec_cmd(
		"dbus-update-activation-environment --systemd "
			.. "WAYLAND_DISPLAY "
			.. "XDG_CURRENT_DESKTOP "
			.. "XDG_SESSION_TYPE "
			.. "XDG_SESSION_DESKTOP "
			.. "HYPRLAND_INSTANCE_SIGNATURE"
	)

	-- Notifications daemon

	hl.exec_cmd("mako")

	-- Wallpaper daemon (swww)

	hl.exec_cmd("swww-daemon")

	-- NetworkManager applet

	hl.exec_cmd("nm-applet --indicator")

	-- Bluetooth applet

	hl.exec_cmd("blueman-applet")

	-- Set a default wallpaper

	hl.exec_cmd("sleep 1 && ~/.config/hypr/scripts/restore-wallpaper.sh")
end)
