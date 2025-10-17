:

REPO_PATH="$HOME/git/OpenBSD_dotfiles"

set -A DOTFILES ".ksh-gitprompt.sh" ".kshrc" ".profile" ".tmux.conf" ".xinitrc" ".Xmodmap" ".xsession"

printf "\n";

for DOTFILE in "${DOTFILES[@]}"; do
	if [[ -e $HOME/$DOTFILE ]]; then
		printf "[ OK ] %-18s inside ->	%s\n" "$DOTFILE" "$HOME";
		cp $HOME/$DOTFILE $REPO_PATH
		printf "\t\t> File updated\n";
	else
		printf "[ ER ] %-18s not present in -> %s" "$DOTFILE" "$HOME";
	fi
done

printf "\n";
