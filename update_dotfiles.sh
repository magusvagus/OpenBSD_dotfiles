:

REPO_PATH="$HOME/git/OpenBSD_dotfiles"

set -A DOTFILES ".ksh-gitprompt.sh" ".kshrc" ".profile" ".tmux.conf" ".xinitrc" ".Xmodmap" ".xsession" ".Xresources"

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
