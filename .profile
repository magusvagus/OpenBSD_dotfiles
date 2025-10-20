# $OpenBSD: dot.profile,v 1.8 2022/08/10 07:40:37 tb Exp $
#
# sh/ksh initialization

# .kshrc (config, runs every time when shell starts)
# .profile (initialisation config runs only once at start )
#	this is why .profile has to point to .kshrc to set the envirometn

PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin

ENV="$HOME/.kshrc"
export ENV

export PATH HOME TERM

export MPD_HOST="$HOME/.config/mpd/socket"
#source ~/.bashrc
