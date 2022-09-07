# GIT heart FZF
# -------------

__fzf_git_is_in_git_repo() {
	git rev-parse HEAD > /dev/null 2>&1
}

__fzf_git_cmd() {
	# Refer to
	# https://github.com/junegunn/fzf/blob/master/shell/key-bindings.bash for
	# more information about __fzfcmd.
	$(__fzfcmd) --bind=ctrl-z:ignore "$@"
}

_fzf_git_files() {
	__fzf_git_is_in_git_repo || return 1

	git -c color.status=always status --short |
		__fzf_git_cmd -m --ansi --nth 2..,.. \
			--preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1})' |
		cut -c4- | sed 's/.* -> //'
}

_fzf_git_branches() {
	__fzf_git_is_in_git_repo || return 1

	git branch -a --color=always --sort=-committerdate | grep -v '/HEAD\s' |
		__fzf_git_cmd --ansi --multi \
			--preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
		sed 's/^..//' | cut -d' ' -f1 |
		sed 's#^remotes/##'
}

_fzf_git_tags() {
	__fzf_git_is_in_git_repo || return 1

	git tag --sort -version:refname |
		__fzf_git_cmd --multi \
			--preview 'git show --color=always {}'
}

_fzf_git_log() {
	__fzf_git_is_in_git_repo || return 1

	git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
		__fzf_git_cmd --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
			--header 'Press CTRL-S to toggle sort' \
			--preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
		grep -o "[a-f0-9]\{7,\}"
}

_fzf_git_remotes() {
	__fzf_git_is_in_git_repo || return 1

	git remote -v | awk '{print $1 "\t" $2}' | uniq |
		__fzf_git_cmd \
			--preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1}' |
		cut -d$'\t' -f1
}

_fzf_git_stashes() {
	__fzf_git_is_in_git_repo || return 1

	git stash list | __fzf_git_cmd --reverse -d: --preview 'git show --color=always {1}' |
		cut -d: -f1
}

_fzf_git_worktree() {
	__fzf_git_is_in_git_repo || return 1

	git worktree list --porcelain | grep '^worktree ' | cut -d' ' -f2 | __fzf_git_cmd --reverse --preview 'git -C {} status'
}
