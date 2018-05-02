function git-set-user {
	local repoUrl=$1
	local shortRepoUrl=$(_get-short-url $repoUrl)

	local name=$(_get-git-user-var name $shortRepoUrl)
	local email=$(_get-git-user-var email $shortRepoUrl)

	git config user.name "$name"
	git config user.email "$email"
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

function _get-git-user-var {
	local variable="$1"
	local url="$2"

	git config --get-urlmatch user.$variable $url 2>/dev/null ||
		git config user.$variable
}
