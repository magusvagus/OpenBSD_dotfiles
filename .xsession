#! /bin/sh
	


	# initialize korn shell profile file
	# this must be only used when using XENODM, as it uses natively xterm as a login shell not our custom one
	. /home/ed/.profile

	# here we put everything that needs to be started after running "statx"
	xrdb -merge "$HOME/.Xresources"

	# set mouse to default theme (so it doesent blink while bootup)
    	/usr/X11R6/bin/xsetroot -xcf /home/ed/.local/share/icons/Everforest-C/cursors/default 32

	# remove mouse cursor
	xbanish -s -t 2 -m nw &

	# allows to use the mouse using keyboard
	keynav "loadconfig ~/.config/keynav/keynavrc" &

	# locks screen after 10 minutes
    	xidle -area 6 -delay 5 -ne -program "/usr/local/bin/slock" -timeout 599 &
	
	# sets wallpaper
	feh --bg-scale /home/ed/wallpaper/gruvbox/hyundai.png &

	# starts compositor
	picom --config ~/.config/picom/picom.conf &

	# sets custom bash command line
	# export PS1=" \[\e[32m\]󰊠\[\e[m\]\[\e[32m\] \[\e[m\]\[\e[32m\]\w\[\e[m\] "
	 
	# if you have a ThinkPad, the following lines enable TrackPoint
	# scrolling by dragging with the middle button.
	xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation" 1 
	xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Button" 2 
	xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Axes" 6 7 4 5

	# activates slstatus dwm bar status output
	slstatus &

	exec dwm
