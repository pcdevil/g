# g
a simple git wrapper to extend it with a few basic commands.

## Install

1. Clone the repositoy to a desired folder
```zsh
$ git clone git@github.com:pcdevil/g.git ~/.g
```

2. Bootstrap it in your `.zshrc`
```zsh
# Export the destionation folder as G_DIR variable
export G_DIR=$HOME/.g
# Add bin folder to the PATH
export PATH=$G_DIR/bin:$PATH
# Load the init script of g
source $G_DIR/g.plugin.zsh
```

## Features

### g
The `g` command is the starting point of all other script and provides a
convenient alias for `git`.
Calling it without arguments executes the [git status] itself if the _CWD_ is a
git repository, otherwise calls the [git help] command.

### cd
Similarly to the built-in `cd` command, this changes the current directory too
but it jumps to a directory relative to the git root. It can be handy if your
project is several level deep and have to change directory very often to an
upper level folder (eg.: `dist`, `node_modules`).

#### Signature
```zsh
$ g cd <directory>
```

#### Arguments
- `directory`: The directory path where to jump

### set-user
Sets the username locally in the repository by reading it from the corresponding
configs.
It comes handy when you are working on multiple git servers but it requires
setup to work.

By default it uses the current repository's _origin_ remote url and reads the
`user.name`, `user.email` and `user.signingkey` configs from [git config] with
the benefit of the [url match functionality].

When reading the configurations, `set-user` strips down the url and only works
with the _PROTOCOL + DOMAIN + TLD_ triple. If there is no match for the given
url it will fall back to the default values.

The `set-user` can turn on GPG signing for the repository too. To enable this
functionality set the `user.signingkey` alongside with the other options.

#### Alias
`su`

#### Signature
```zsh
$ g set-user [repository_url]
```

#### Arguments
- `repository_url`: Allows to redefine the repository url for the config reads.

#### Setup
For proper working you have to add more options to the [git global config].
There is a way to do it by git commands but (it's not pretty):
```zsh
$ git config --global 'user.https://github.com.email' 'jakab@gipsz.eu'
$
$ git config --global 'user.https://example.org.email' 'jakab.gipsz@example.org'
$ git config --global 'user.https://example.org.name' 'jakab.gipsz'
$ git config --global 'user.https://example.org.signingkey' '0000000000000042'
```

This will add new sections to the `~/.gitconfig` file with the following
content:
```gitconfig
[user "https://github.com"]
email = jakab@gipsz.eu

[user "https://example.org"]
email      = jakab.gipsz@example.org
name       = jakab.gipsz
signingkey = 0000000000000042
```

_Note_: If you prefer, you can edit the config manually to achieve the same
result.

#### Examples
- Call it without argument inside a git repository.
```zsh
$ cd g
$ # verify the e-mail has a default value
$ git config --get --local user.email
jakab@gipsz.family
$ git config --get remote.origin.url
git@github.com:pcdevil/g.git
$ g set-user
$ # get the new value for e-mail
$ git config --get --local user.email
jakab@gipsz.eu
$ # signingkey is not defined because it's not populated for the this repository
$ git config --get --local user.signingkey
$
```

- Passed url is respected too.
```zsh
$ mkdir ~/example-org-site
$ cd ~/example-org-site
$ g init
Initialized empty Git repository in /Users/jakab.gipsz/example-org-site/.git
$
$ # this is equivalent as `g su "https://example.org"`
$ g su "git@dev.example.org:site-team/example-org-site.git"
$ # get the new values
$ git config --get --local user.name
jakab.gipsz
$ git config --get --local user.email
jakab.gipsz@example.org
$ # for this use-case signingkey is populated too
$ git config --get --local user.signingkey
0000000000000042
$
```

### super-init
Initiates a new git repository folder with populated `README.md`, `LICENSE.md`
and `.gitignore`.

By default the readme file will hold the name of the project and a link to the
license file. Defining a description as argument will result to fill it the
readme file with it.

The license will be [MIT].

To make the `.gitignore` file the command will download the content from
[gitignore.io].

The following templates are applied by default:
- **Operating systems**: Linux, macOS, Windows
- **Editors**: IntelliJ+all, Vim, Visual Studio Code

If a _[type]_ is also defined then the appropriate programming language will be
added to the ignore too. Currently supported languages are `java`, `node`, `php`
and `rust`.

#### Alias
`si`

#### Signature
```zsh
$ g super-init <directory> [type] [description]
```

#### Arguments
- `directory`: The target directory name of the project.
- `type`: The _"programming language"_ to use for the `.gitignore` file.
- `description`: Optional description for the `README.md`.

### take
This command is _enhanced_ [git clone]. The `take` after cloning will clone the
submodules too. As the name suggest, the _CWD_ will be changes as well,
similarly as the [oh-my-zsh's take].

After cloning and entering the directory, it will run the [git-set-user] command
for user option setup.

#### Alias
`ta`

#### Signature
```zsh
$ g take <repository_url> [directory]
```

#### Arguments
- `repository_url`: The pulled repository's url
- `directory`: Optional, the output directory where to clone

## License
Available under the [MIT license](LICENSE.md).

[git clone]: https://git-scm.com/docs/git-clone
[git config]: https://git-scm.com/docs/git-config
[git global config]: https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
[git help]: https://git-scm.com/docs/git-help
[git status]: https://git-scm.com/docs/git-status
[git-set-user]: #set-user
[gitignore.io]: https://gitignore.io
[MIT]: https://opensource.org/licenses/MIT
[oh-my-zsh's take]: https://github.com/robbyrussell/oh-my-zsh/wiki/Cheatsheet
[url match functionality]: https://git-scm.com/docs/git-config#Documentation/git-config.txt---get-urlmatchnameURL
