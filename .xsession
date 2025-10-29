#! /bin/sh

	# initialize korn shell profile file
	# this must be only used when using XENODM, as it uses natively xterm as a login shell not our custom one
	. "$HOME/.profile"

	# here we put everything that needs to be started after running "startx"
	xrdb -merge "$HOME/.Xresources"

	# set mouse to default theme (so it doesent blink while bootup)
    /usr/X11R6/bin/xsetroot -xcf /usr/local/share/icons/Everforest-C/cursors/default 32

	# source ~/.Xmodmap for custom keymaps
	# (setting Caps Lock -> Tab)
	xmodmap "$HOME/.Xmodmap"

	# remove mouse cursor
	xbanish -s -t 2 -m nw &

	# allows to use the mouse using keyboard
	keynav "loadconfig $HOME/.config/keynav/keynavrc" &

	# locks screen after 10 minutes
	xidle -timeout 599 -program "/usr/local/bin/slock" &
	
	# sets wallpaper
	feh --bg-scale --randomize "$HOME/wallpaper/current_active/*" &

	# starts compositor
	picom --config "$HOME/.config/picom/picom.conf" &

	# if you have a ThinkPad, the following lines enable TrackPoint
	# scrolling by dragging with the middle button.
	xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation" 1 
	xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Button" 2 
	xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Axes" 6 7 4 5

	# activates slstatus dwm bar status output
	slstatus &

	exec dwm
