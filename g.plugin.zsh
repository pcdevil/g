unalias g
function g {
	if [ $# -gt 0 ]; then
		git "$@"
	elif git rev-parse --is-inside-work-tree >/dev/null 2>/dev/null; then
		git status
	else
		git --help
	fi
	return $?
}

compdef g=git
