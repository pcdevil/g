unalias g
function g {
	if [ $# -gt 0 ]; then
		git "$@"
	else
		if git symbolic-ref HEAD >/dev/null 2>/dev/null; then
			git status
		else
			git --help
		fi
	fi
	return $?
}

compdef g=git
