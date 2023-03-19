__fzf_git_cmd() {
	# Refer to
	# https://github.com/junegunn/fzf/blob/master/shell/key-bindings.bash for
	# more information about __fzfcmd.
	$(__fzfcmd) --bind=ctrl-z:ignore "$@"
}

_fzf_git_worktree() {
	_fzf_git_check || return 1

	git worktree list --porcelain |
		grep '^worktree ' |
		cut -d' ' -f2 |
		__fzf_git_cmd \
		--reverse \
		--preview 'git -C {} status'
}
