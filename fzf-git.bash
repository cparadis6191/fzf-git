__fzf_git_fzf() {
	# Refer to
	# https://github.com/junegunn/fzf-git.sh/blob/main/README.md#customization
	# for more information about _fzf_git_fzf.
	_fzf_git_fzf "$@"
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
