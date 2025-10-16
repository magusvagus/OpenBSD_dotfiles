#!/bin/sh

prefix="/usr"
exec_prefix="${prefix}"
xrdb="xrdb"
xinitdir="/etc/X11/xinit"
xclock="xclock"
xterm="xterm"
twm="twm"
xmodmap="xmodmap"

userresources="$HOME/.Xresources"
usermodmap="$HOME/.Xmodmap"
sysresources="$xinitdir/Xresources"
sysmodmap="$xinitdir/Xmodmap"

# merge in defaults and keymaps

if [ -f "$sysresources" ]; then
    if [ -x /usr/bin/cpp ] ; then
        "$xrdb" -merge "$sysresources"
    else
        "$xrdb" -nocpp -merge "$sysresources"
    fi
fi

if [ -f "$sysmodmap" ]; then
    "$xmodmap" "$sysmodmap"
fi

if [ -f "$userresources" ]; then
    if [ -x /usr/bin/cpp ] ; then
        "$xrdb" -merge "$userresources"
    else
        "$xrdb" -nocpp -merge "$userresources"
    fi
fi

if [ -f "$usermodmap" ]; then
    "$xmodmap" "$usermodmap"
fi

# start some nice programs

if [ -n "`/etc/X11/chooser.sh`" ]; then
	command="`/etc/X11/chooser.sh`"
else
	failsafe="yes"
fi

if [ -d "$xinitdir"/xinitrc.d ] ; then
	for f in "$xinitdir/xinitrc.d"/?* ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

if [ -n "$failsafe" ]; then

	# here we put everything that needs to be started after running "statx"
	xrdb -merge "$HOME/.Xresources"

	# source ~/.Xmodmap for custom keymaps
	# (setting Caps Lock -> Tab)
	xmodmap ~/.Xmodmap

	# remove mouse cursor
	xbanish -s -t 2 & #-m nw &

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

else
	exec $command
fi



