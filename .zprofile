if [ -z "$DISLAY" ] && [ "$XDG_VTNR" = 1 ]; then
	export XDG_CURRENT_DESKTOP=sway:wlroots

	#exec qtile start -b wayland &> /dev/null
	# exec qtile start &> /dev/null
	
	#exec dbus-run-session sway
	exec Hyprland
fi
