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
			git-cd "$@"
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

function git-cd {
	local gitRootDir=$(command git rev-parse --show-toplevel 2>/dev/null)

	cd "$gitRootDir/$@"
	return $?
}

function git-take {
	local repository="$1"
	local directory=${2:-$(basename $repository .git)}

	git clone --recurse-submodules $repository $directory &&
		cd $directory &&
		git set-user $repository
	return $?
}

unalias g
alias g=git
