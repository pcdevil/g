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

	local commandName="$1"
	local gitCommand=""
	case $commandName in
		cd)                   gitCommand=git-cd ;;
		ng-ci|angular-commit) gitCommand=git-angular-commit ;;
		si|super-init)        gitCommand=git-super-init ;;
		su|set-user)          gitCommand=git-set-user ;;
		sw-m|switch-main)     gitCommand=git-switch-main ;;
		ta|take)              gitCommand=git-take ;;
	esac

	if [ -n "$gitCommand" ]; then
		shift
		. "$G_DIR/bin/$gitCommand" "$@"
	else
		command git "$@"
	fi
	return $?
}

alias g=git
