# Redefine this function to change the options
__fzf_git_fzf() {
	fzf --height=50% --tmux 90%,70% \
		--layout=reverse --multi --min-height=20 --border \
		--border-label-pos=2 \
		--color='header:italic:underline,label:blue' \
		--preview-window='right,50%,border-left' \
		--bind='ctrl-/:change-preview-window(down,50%,border-top|hidden|)' "$@"
}

_fzf_git_worktree() {
	_fzf_git_check || return 1

	git worktree list --porcelain |
		grep '^worktree ' |
		cut --delimiter=' ' --fields=2 |
		__fzf_git_fzf \
		--preview 'git -C {} status' \
		--prompt '👷🌲 Worktrees> '
}
