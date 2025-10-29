#!/bin/ksh

# ------------------
# DEAD CODE TO CHECK
# ------------------

# this is only needed when installing nvim from source
# where the bin and runtime of neovim is located somewhere else
#alias nvim='VIMRUNTIME=/home/$USER/git/neovim/runtime /home/$USER/git/neovim/build/bin/nvim'

# --------------------------------------------------------------------------

# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
#if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
#	return
#fi


# -----------
# KSH OPTIONS
# -----------

TERM=xterm-256color

# set standart system editor
export VISUAL=vim
export EDITOR="$VISUAL"

# for tmux to render Nerd font symbols
LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# add every command used to history
#export PROMPT_COMMAND='history -a'

# set ksh history file size 
# (number of stored commands) defualt is 500
export HISTFILE="$HOME/.ksh_history"
export HISTSIZE=2500
export HISTFILESIZE=2500

# activate vim mode for ksh
set -o vi
set -o vi-tabcomplete #enable tab completion in vi mode using =

# export socket for mpd
export MPD_HOST="$HOME/.config/mpd/socket"


# ---------
# FUNCTIONS
# ---------

function wttr
{
	# add help option
	typeset _input _set_place

	for _arg in "$@";do
		case "$_arg" in
			*)
				if [[ $# -gt 1 ]]; then
					printf "weather: Too many arguments.\n"
					return 1
				fi

				_set_place=true
				_input="$1"
				;;
		esac
	done

	if [[ "$_set_place" == true ]]; then
		curl wttr.in/$_input;
	else
		curl -s wttr.in/$(curl -s ipinfo.io/city);
	fi
}

# swallow function
function swlw
{
	TERMINAL_ID=$(xdotool getactivewindow)
	"$@" &
	PROGRAM_PID=$!
	until WINDOW_ID=$(xdotool search --pid $PROGRAM_PID 2>/dev/null); do
		sleep 0.1
	done
	xdotool windowunmap $TERMINAL_ID
	wait $PROGRAM_PID
	xdotool windowmap $TERMINAL_ID   
}

# turn on webcam streaming
function streaming
{  
	if [[ $1 = "on" ]]; then
		doas sysctl kern.audio.record=1;
		xhost +local:;
		printf "Video streaming -> enabled\n";
	elif [[ $1 = "off" ]]; then
		doas sysctl kern.audio.record=0;
		xhost -local:;
		printf "Video streaming -> disabled\n";
	else
		printf "ERR: invalid flag\n";
	fi
}

# toggle display power saver
function display
{
	if [[ $1 = "on" ]]; then
		xset s on +dpms;  
		printf "Display power management -> enabled\n"
	elif [[ $1 = "off" ]]; then
		xset s off -dpms;  
		printf "Display power management -> disabled\n"
	elif [[ $1 = "brighness" ]]; then
		doas /sbin/wsconsctl display.brightness=$2;
	else
		printf "ERR: invalid flag\n";
	fi
}

# calculator with color indicator
function ccal
{  
	DAY=$(date +%e | tr -d ' ')  # Remove leading space   
	cal | sed -E "s/(^|[^0-9])($DAY)([^0-9]|$)/\1$(tput setaf 1)$(tput bold)\2$(tput sgr0)\3/g"   
}


# ----------------------------
# DESKTOP ENVIROMENT DETECTION
# ----------------------------

# this script checks if X is on and set the according aliases and bash prompt

# look for process using a regex character class
# [process] means look for anything matching inside brackets
# so grep searches for 'process', but not itself cause grep's
# promt was 'pr[o]cess'


# XTEST=$(ps -e | grep X)
# XENOTEST=$(ps aux | grep -ow 'x[e]nodm')
ST_TEST=$(ps aux | grep -ow 's[t]') # look for st terminal

if [[ -z "$ST_TEST" ]]; then

	echo " "
	#echo " No X server detected!"
	echo " No st terminal detected!"
	echo " Entering tyy mode."
	echo " "
	alias neofetch='\fastfetch --config none'

		# experimental
	alias swallow='swlw'
	alias cal='ccal'
	alias weather='wttr'

	# program shorcuts
	alias ls='ls'
	alias tshark='tshark --color'
	alias cat='cat'
	alias vi='vim'
		# experimental

else
	# git script to show git status
	# if git script exists, source it
	if [ -f "$HOME/.ksh-gitprompt.sh" ]; then
		GIT_PS1_SHOWUPSTREAM="auto"
		GIT_PS1_DESCRIBE_STYLE="contains"
		GIT_PS1_SHOWUPSTREAM="verbose"
		GIT_PS1_SHOWDIRTYSTATE=true
		#GIT_PS1_STATESEPARATOR=" | "
		GIT_PS1_SHOWUNTRACKEDFILES="yes"

		# source ksh git script
		. $HOME/.ksh-gitprompt.sh

		# set custom ksh PS1 command line /w git
		export PS1=" \[\e[35m\]󱢗\[\e[m\]\[\e[35m\] \[\e[m\]\[\e[32m\]\w\[\e[m\]\$(__git_ps1 \" \e[35m\n │\e[36m %s\e[36m]\n\e[35m └󰘧→\e[m\") "   
		alias neofetch='fastfetch'

	else
		# PS1 without git
		export PS1=" \[\e[35m\]󱢗\[\e[m\]\[\e[35m\] \[\e[m\]\[\e[32m\]\w\[\e[m\] "
		alias neofetch='fastfetch'
	fi

	# run the termnal only with tmux, when the X server/ st term is running.
	# for tmux keep starting with terminal, not replicating inside itself
	if [[ -z $TMUX ]]; then
		exec tmux
	fi

	#run neofetch if st terminal is present
	clear
	fastfetch
fi


# ------------------
# DEAD CODE TO CHECK
# ------------------

# alias tmux="tmux -f ~/.tmux.conf"
# # for tmux keep starting with terminal, not replicating inside itself
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi


# -------
# aliases
# -------

# function aliases
alias swallow='swlw'
alias cal='ccal'
alias weather='wttr'

# fzf aliases
alias hif='$(cat ~/.ksh_history | fzf)'
alias cdf='cd $(find . -type d -print | fzf)'
alias vif='nvim $(fzf -m --preview="cat {}");'

# online services
alias bitcoin='curl rate.sx/btc@1w' # check week of btc
alias btc='curl rate.sx/btc' # check btc today
alias ip='printf "External IP -> "; curl ifconfig.me; printf "\n"' # website to check external ip

# program shorcuts
alias ls='lsd'
alias tshark='tshark --color'
alias cat='bat'

#alias vim='nvim'
alias vi='nvim'

# bash '$ doas !!' alternative for ksh
alias doas!!='doas $(fc -ln -1)'

alias music='ncmpcpp'



