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
	".config/picom" \
	".config/nvim" \

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

for DOT_CONF in "${DOT_CONF[@]}"; do
	if [[ -e $HOME/$DOT_CONF ]]; then
		# printf "[ OK ] %-18s inside ->	%s -> UPDATED\n" "$DOT_CONF" "$HOME";
		# cp $HOME/$DOT_CONF $REPO_PATH
	else
		# printf "[ ER ] %-18s not present in -> %s" "$DOT_CONF" "$HOME";
	fi
done

printf "\n";
