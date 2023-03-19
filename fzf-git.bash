__fzf_git_is_in_git_repo() {
	git rev-parse HEAD > /dev/null 2>&1
}

__fzf_git_cmd() {
	# Refer to
	# https://github.com/junegunn/fzf/blob/master/shell/key-bindings.bash for
	# more information about __fzfcmd.
	$(__fzfcmd) --bind=ctrl-z:ignore "$@"
}

_fzf_git_worktree() {
	__fzf_git_is_in_git_repo || return 1

	git worktree list --porcelain | grep '^worktree ' | cut -d' ' -f2 | __fzf_git_cmd --reverse --preview 'git -C {} status'
}
