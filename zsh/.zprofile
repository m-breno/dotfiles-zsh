if [ -z "$DISLAY" ] && [ "$XDG_VTNR" = 1 ]; then
	exec qtile start -b wayland &> /dev/null
fi
