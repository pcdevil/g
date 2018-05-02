function git-cd {
	local gitRootDir=$(command git rev-parse --show-toplevel 2>/dev/null)

	cd "$gitRootDir/$@"
	return $?
}
