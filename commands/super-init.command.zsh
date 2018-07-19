function git-super-init {
	local name=$1
	local type=$2

	_git-super-init__create-folder
	_git-super-init__create-license
	_git-super-init__create-readme
	_git-super-init__create-gitignore
	_git-super-init__create-tmp
	_git-super-init__create-commit
}

function _git-super-init__create-folder {
	mkdir --parents $name
	cd $name
	git init
}

function _git-super-init__create-license {
	local year=$(date +%Y)
	local author=$(git config user.name)
	local url=$(git config user.web)

	(
		echo "# The MIT License"
		echo
		echo "Copyright 2011-$year $author $url"
		echo
		cat $G_DIR/assets/mit-license
	) >LICENSE.md
}

function _git-super-init__create-readme {
	(
		echo "# $name"
		echo
		echo "## License"
		echo "Available under the [MIT license](LICENSE.md)."
	) >README.md
}

function _git-super-init__create-gitignore {
	local base_url="https://www.gitignore.io/api/"

	local os_ignores=(linux osx windows)
	local editor_ignores=(intellij+all vim visualstudiocode)
	local node_ignores=(node)
	local php_ignores=(composer)

	local typed_ignored_variable=${type}_ignores
	local typed_ignores=${(P)typed_ignored_variable}

	local ignores=($os_ignores $typed_ignores $editor_ignores)

	curl --silent --show-error --location $base_url${(j:,:)ignores} >.gitignore
}

function _git-super-init__create-tmp {
	mkdir --parent tmp
	touch tmp/.gitkeep
	(
		 echo
		 echo "### Project ###"
		 echo "/tmp/"
	) >>.gitignore
}

function _git-super-init__create-commit {
	git add --force .
	git commit --message="chore($name): initial commit"
}
