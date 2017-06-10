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
		g|git)
			shift
			git "$@"
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

function git-cd {
	local gitRootDir=$(command git rev-parse --show-toplevel 2>/dev/null)

	cd "$gitRootDir/$@"
	return $?
}

function git-set-user {
	local repoUrl=$1
	local shortRepoUrl=$(_get-short-url $repoUrl)

	local name=$(_get-git-user-var name $shortRepoUrl)
	local email=$(_get-git-user-var email $shortRepoUrl)

	git config user.name "$name"
	git config user.email "$email"
}

function git-take {
	local repository="$1"
	local directory=${2:-$(basename $repository .git)}

	git clone --recurse-submodules $repository $directory &&
		cd $directory &&
		git-set-user $repository
	return $?
}

function _get-git-user-var {
	local variable="$1"
	local url="$2"

	git config --get-urlmatch user.$variable $url 2>/dev/null ||
		git config user.$variable
}

function _get-short-url {
	local domain="$1"

	if [[ -z $domain ]]; then
		return
	fi

	# remove anything before @ (deals with git@ and other username/passwords)
	domain=${domain#*@}

	# save and remove protocol
	local protocol=${domain%%://*}
	if [[ ${#protocol} == ${#domain} ]]; then
		protocol=https
	fi
	protocol=${protocol}://
	domain=${domain#*://}

	# remove port (and username if git@ url)
	domain=${domain%%:*}

	# remove pathname
	domain=${domain%%/*}

	# save and remove tld
	local tld=${domain##*.}
	if [[ ${#tld} == ${#domain} ]]; then
		tld=""
	else
		tld=.${tld}
	fi
	domain=${domain%.*}

	# remove subdomains
	domain=${domain##*.}

	echo $protocol$domain$tld
}

unalias g
alias g=git
