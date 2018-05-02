function git-take {
	local repository="$1"
	local directory=${2:-$(basename $repository .git)}

	git clone --recurse-submodules $repository $directory &&
		cd $directory &&
		git-set-user $repository
	return $?
}
