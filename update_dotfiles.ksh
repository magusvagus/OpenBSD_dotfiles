#!/bin/ksh

REPO_PATH="$HOME/git/OpenBSD_dotfiles"

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
set -A DOT_CONF \
	".config/fastfetch" \
	".config/keynav" \
	".config/mpd" \
	".config/picom"

printf "\n";

for DOTFILE in "${DOTFILES[@]}"; do
	if [[ -e $HOME/$DOTFILE ]]; then
		printf "[ OK ] %-18s inside ->	%s -> UPDATED\n" "$DOTFILE" "$HOME";
		cp $HOME/$DOTFILE $REPO_PATH
	else
		printf "[ ER ] %-18s not present in -> %s" "$DOTFILE" "$HOME";
	fi
done

printf "\n";
