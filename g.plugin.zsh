#!/usr/bin/env zsh

gRootDir=$(dirname $(realpath $0))
gBinDir=$gRootDir/bin

function git {
	local gitRootDir=$(command git rev-parse --show-toplevel 2>/dev/null)

	if [[ $# > 0 ]]; then
		# call git with the given arguments
		command git $@
	elif [[ -n "$gitRootDir" ]]; then
		# show repository status if current directory is a repo
		command git status
	else
		# otherwise show the help
		command git --help
	fi

	# use the exit status of git
	return $?
}

alias g=git

path=(
	$gBinDir
	$path
)
