#!/bin/ksh

REPO_PATH="$HOME/git/OpenBSD_dotfiles"
CONFIG_PATH="$HOME/git/OpenBSD_dotfiles/dot_config"

# $HOME dotfiles
set -A DOTFILES \
	".ksh-gitprompt.sh" \
	".kshrc" \
	".profile" \
	".tmux.conf" \
	".xinitrc" \
	".Xmodmap" \
	".xsession" \
	".Xresources" \

# .config files
#  1 Section: cli-tools
#  2 Section: suckless
#  3 Section: gui-tools
set -A CONFIGS \
	\
	".config/fastfetch" \
	".config/keynav" \
	".config/mpd" \
	".config/picom" \
	".config/btop" \
	".config/htop" \
	".config/cmus" \
	".config/weechat" \
	\
	".config/slstatus" \
	".config/dmenu" \
	".config/dwm" \
	".config/slock" \
	".config/st" \
	\

	# Removed
#
	# cli-tools
		#".config/nvim" \

	# gui-tools
		#".config/qutebrowser" \
		#".config/wireshark" \

printf "\n";

for DOTFILE in "${DOTFILES[@]}"; do
	if [[ -e $HOME/$DOTFILE ]]; then
		printf "[ OK ] %-18s inside ->	%s -> UPDATED\n" "$DOTFILE" "$HOME";
		cp $HOME/$DOTFILE $REPO_PATH
	else
		printf "[ ER ] %-18s not present in -> %s\n" "$DOTFILE" "$HOME";
	fi
done

printf "\n";

for CONF in "${CONFIGS[@]}"; do
	if [[ -e $HOME/$CONF ]]; then
		printf "[ OK ] %-18s inside ->	%s -> UPDATED\n" "$CONF" "$HOME";
		cp -r $HOME/$CONF $CONFIG_PATH
	else
		printf "[ ER ] %-18s not present in -> %s\n" "$CONF" "$HOME";
	fi
done

printf "\n";
