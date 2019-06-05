source $G_DIR/commands/take.command.zsh

function git {
	local gitRootDir=$(command git rev-parse --show-toplevel 2>/dev/null)

	if [ $# -eq 0 ]; then
		if [ -n "$gitRootDir" ]; then
			command git status
		else
			command git --help
		fi
		return $?
	fi

	local command="$1"
	case $command in
		cd)
			shift
			. git-cd "$@"
			;;
		g|git)
			shift
			git "$@"
			;;
		si|super-init)
			shift
			. git-super-init "$@"
			;;
		su|set-user)
			shift
			git-set-user "$@"
			;;
		ta|take)
			shift
			git-take "$@"
			;;
		*)
			command git "$@"
			;;
	esac
	return $?
}

unalias g
alias g=git
