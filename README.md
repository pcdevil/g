# g
a git wrapper to extend it with a few commands. See detailed functionality in
the **[Features]** section!

### Table of Contents
- **[Install]**
  - **[Prerequirements]**
  - **[Steps]**
- **[Predefined git config]**
  - **[Abbreviation aliases]**
  - **[Basic aliases]**
  - **[Advanced aliases]**
- **[Features]**
  - **[g]**
  - **[angular-commit]**
  - **[cd]**
  - **[set-user]**
  - **[super-init]**
  - **[take]**
- **[License]**

---

## Install

### Prerequirements
- unix-like system
- [git] (minimum: v1.7+, recommended: v2.23+)
- [zsh]

### Steps

1. Clone the repositoy to a desired folder:
```zsh
$ git clone git@github.com:pcdevil/g.git ~/.g
```

2. Bootstrap it in your `.zshrc`:
```zsh
# Export the destionation folder as G_DIR variable
export G_DIR=$HOME/.g
# Add bin folder to the PATH
export PATH=$G_DIR/bin:$PATH
# Load the init script of g
source $G_DIR/g.plugin.zsh
```

3. (Optional) Install `gitconfig`:
```zsh
$ git config --global --add include.path ~/.g/gitconfig
```

__See **[Predefined git config]** section for more information about it.__

4. Reload the terminal.

## Predefined git config
The project provides an optional `gitconfig` to extend the default **git**
config. Currently it only contains aliases, which can be sorted into three
categories, listed below.

### Abbreviation aliases
Abbreviation aliases are very simple: their purpose to give quicker access to a
specific git command.

| Alias command | **git** command |
| ------------- | --------------- |
| `br`          | `git branch`    |
| `cl`          | `git clone`     |
| `d`           | `git diff`      |
| `me`          | `git merge`     |
| `ph`          | `git push`      |
| `pl`          | `git pull`      |
| `re`          | `git restore`   |
| `sh`          | `git show`      |
| `st`          | `git status`    |
| `sw`          | `git switch`    |

_Note_: [git restore] and [git switch] only available since **git** v2.23, below
thaat the `re` and the `sw` alias produces error!

_Note_: All features of `g` also have an abbreviation alias, which described in
the their respective descriptions.

### Basic aliases
Basic aliases give flavour for everyday situation usages, while they still keep
the durability of the base command and allow free parametrisation for them.

| Alias command | **git** command          | Description                                                                             |
| ------------- | ------------------------ | --------------------------------------------------------------------------------------- |
| a             | add --patch              | Add file chunks interactively                                                           |
| a-f           | add --intent-to-add      | Set file as intended to add                                                             |
| ci-a          | commit --amend           | Amend last commit                                                                       |
| ci-as         | commit --amend --no-edit | Amend last commit and use the same message                                              |
| d-s           | diff --staged            | Show staged changes                                                                     |
| f             | fetch --prune --all      | Download references from all remote and remove any local reference that no longer exist |
| me-m          | merge --no-ff            | Merge and always create merge commit                                                    |
| me-s          | merge --no-edit          | Merge and use suggested message                                                         |
| me-ms         | merge --no-ff --no-edit  | Merge and always create merge commit with suggested message                             |
| re-s          | restore --staged         | Restore staged changes                                                                  |
| sw-m          | switch master            | Switch to master branch                                                                 |

While [angular-commit] is not a standard **git** command, basic aliases are also
provided for it out of the box.

| Alias command | **angular-commit** command  |
| ------------- | --------------------------- |
| ci-build      | git-angular-commit build    |
| ci-docs       | git-angular-commit docs     |
| ci-feat       | git-angular-commit feat     |
| ci-fix        | git-angular-commit fix      |
| ci-perf       | git-angular-commit perf     |
| ci-refactor   | git-angular-commit refactor |
| ci-style      | git-angular-commit style    |
| ci-test       | git-angular-commit test     |

### Advanced aliases
Contrary to the previous alias types, advanced aliases are designed to give
solution in a strict situation without taking account other type of application.
See the "Notes" section how they allow parametrisation for the underlying
**git** command!

| Alias command | Description                                                           | Notes                                                           |
| ------------- | --------------------------------------------------------------------- | --------------------------------------------------------------- |
| l             | Print a coloured, compact one-liner log                               | Only `--pretty=format` used, any other [git log] argument works |
| ph-o          | Set upstream to origin and push the current branch                    | Doesn't take any argument                                       |
| re-2          | Restore both staged and unstaged changes                              | Any argument is passed through to [git restore]                 |
| ci            | Quick commit where neither the changes, nor the message are mandatory | Any argument will be passed as message to [git commit]          |

## Features

### g
The `g` command is the starting point of all other script and provides a
convenient alias for `git`.
Calling it without arguments executes the [git status] itself if the _CWD_ is a
git repository, otherwise calls the [git help] command.

---

### angular-commit
Creates a commit in compliance with the [Angular's Commit Message Guidelines].

#### Alias
`ng-ci`

#### Signature
```zsh
$ g angular-commit <type> <scope> <message>
```

#### Arguments
- `type`: The type part of the commit message, which is [described in the
  guideline here].
- `scope`: The scope part of the commit message.
- `message`: The subject and body part of the commit message.

#### Advanced use
In order to use this feature more conviently, it's advised to create aliases for
commonly used types in the [git config], for example:
```zsh
$ git config --global alias.ng-ci-feat '!git-angular-commit feat'
$ git config --global alias.ng-ci-fix '!git-angular-commit fix'
$ git config --global alias.ng-ci-test '!git-angular-commit test'
```

This will add new sections to the `~/.gitconfig` file with the following
content:
```gitconfig
[alias]
ng-ci-feat = !git-angular-commit feat
ng-ci-fix = !git-angular-commit fix
ng-ci-test = !git-angular-commit test
```

_Note_: If you prefer, you can edit the config manually to achieve the same
result.

_Note 2_: Command aliases are available in the predefined git config as [basic
aliases] too without the `ng` prefix.

---

### cd
Similarly to the shell built-in `cd` command, this changes the current directory
too but it jumps to a directory relative to the git root. It can be handy if
your project is several level deep and have to change directory very often to an
upper level folder (eg.: `dist`, `node_modules`).

#### Signature
```zsh
$ g cd <directory>
```

#### Arguments
- `directory`: The directory path where to jump

---

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
There is a way to do it by git commands (but it's not pretty):
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

---

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
- **Custom directories**: `[git root]/tmp` and `[git root]/dist` folders

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

---

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
Available under the [MIT license].

[Abbreviation aliases]: #abbreviation-aliases
[Advanced aliases]: #advanced-aliases
[angular-commit]: #angular-commit
[Angular's Commit Message Guidelines]: https://github.com/angular/angular/blob/master/CONTRIBUTING.md#-commit-message-guidelines
[Basic aliases]: #basic-aliases
[basic aliases]: #basic-aliases
[cd]: #cd
[described in the guideline here]: https://github.com/angular/angular/blob/master/CONTRIBUTING.md#type
[Features]: #features
[g]: #g-1
[git]: https://git-scm.com
[git clone]: https://git-scm.com/docs/git-clone
[git commit]: https://git-scm.com/docs/git-commit
[git config]: https://git-scm.com/docs/git-config
[git global config]: https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
[git help]: https://git-scm.com/docs/git-help
[git log]: https://git-scm.com/docs/git-log
[git restore]: https://git-scm.com/docs/git-restore
[git status]: https://git-scm.com/docs/git-status
[git switch]: https://git-scm.com/docs/git-switch
[git-set-user]: #set-user
[gitignore.io]: https://gitignore.io
[Install]: #install
[License]: #license
[MIT]: https://opensource.org/licenses/MIT
[MIT license]: LICENSE.md
[oh-my-zsh's take]: https://github.com/robbyrussell/oh-my-zsh/wiki/Cheatsheet
[Predefined git config]: #predefined-git-config
[Prerequirements]: #prerequirements
[set-user]: #set-user
[Steps]: #steps
[super-init]: #super-init
[take]: #take
[url match functionality]: https://git-scm.com/docs/git-config#Documentation/git-config.txt---get-urlmatchnameURL
[zsh]: http://www.zsh.org/
