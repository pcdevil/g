# g
A wrapper around **git** with additional feature extension.
See detailed functionality in the **[Features]** section!

### Table of Contents
- **[Install]**
  - **[Prerequirements]**
  - **[Steps]**
- **[Predefined git config]**
  - **[Abbreviation aliases]**
  - **[Basic aliases]**
  - **[Commit aliases]**
    - **[Conventional Commit aliases]**
  - **[Advanced aliases]**
- **[Features]**
  - **[g]**
  - **[conventional-commit]**
  - **[set-user]**
  - **[super-init]**
  - **[switch-main]**
- **[License]**

---

## Install

### Prerequirements
- unix-like system
- [git] (minimum: v1.7+, recommended: v2.35+)
- [zsh]

### Steps
1. Clone the repositoy to a desired folder:
    ```zsh
    $ git clone git@github.com:pcdevil/g.git ~/.g
    ```

2. Bootstrap it in your `.zshrc`:
    ```zsh
    # Load the init script of g. This will do the followings:
    # - installs the `g` command
    # - adds the project's bin directory to the $PATH
    source $HOME/.g/g.plugin.zsh
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

| Alias command | **git** command                  |
| ------------- | -------------------------------- |
| `g ae`        | `git blame` _(as in "annotate")_ |
| `g br`        | `git branch`                     |
| `g cl`        | `git clone`                      |
| `g cp`        | `git cherry-pick`                |
| `g d`         | `git diff`                       |
| `g me`        | `git merge`                      |
| `g ph`        | `git push`                       |
| `g pl`        | `git pull`                       |
| `g q`         | `git stash`                      |
| `g re`        | `git restore`                    |
| `g sh`        | `git show`                       |
| `g sw`        | `git switch`                     |

_Note_: [git restore] and [git switch] only available since **git** v2.23, below
that the `re` and the `sw` alias produces error!

_Note_: All features of `g` also have an abbreviation alias, which described in
the their respective descriptions.

### Basic aliases
Basic aliases give flavour for everyday situation usages, while they still keep
the durability of the base command and allow free parametrisation for them.

| Alias command | Equivalent **git** command           | Description                                                                             |
| ------------- | ------------------------------------ | --------------------------------------------------------------------------------------- |
| `g a`         | `git add --patch`                    | Add file chunks interactively                                                           |
| `g a-f`       | `git add --intent-to-add`            | Set file as intended to add                                                             |
| `g cp-n`      | `git cherry-pick --no-commit`        | Apply an existing commit without creating a new one                                     |
| `g d-s`       | `git diff --staged`                  | Show staged changes                                                                     |
| `g f`         | `git fetch --prune --all`            | Download references from all remote and remove any local reference that no longer exist |
| `g me-m`      | `git merge --no-ff`                  | Merge and always create merge commit                                                    |
| `g me-s`      | `git merge --no-edit`                | Merge and use suggested message                                                         |
| `g me-ms`     | `git merge --no-ff --no-edit`        | Merge and always create merge commit with suggested message                             |
| `g re-s`      | `git restore --staged`               | Restore staged changes                                                                  |
| `g q-ph`      | `git stash push --include-untracked` | Move staged, dirty and untracked (but not ignored) changes into stash                   |
| `g q-pl`      | `git stash pop`                      | Move uppermost changes from stash into working directory                                |
| `g q-s`       | `git stash push --staged`            | Move staged only changes into stash                                                     |

_Note_: [git stash push --staged] only available since **git** v3.35, below that the `g q-s` alias produces error!

### Commit aliases

| Alias command | Equivalent **git** command            | Description                                                                                                           |
| ------------- | ------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `g ci`        | `git commit --message="$@"`           | Commit and use all arguments as message                                                                               |
| `g ci-a`      | `git commit --amend`                  | Amend last commit                                                                                                     |
| `g ci-as`     | `git commit --amend --no-edit`        | Amend last commit and use the same message                                                                            |
| `g ci-ra`     | `git commit --fixup=amend:$1 ${@:2}`  | Commit as _amend_ (fixup and reword) for later [rebased with autosquash], see [git commit fixup] for more information |
| `g ci-rf`     | `git commit --fixup=$1 ${@:2}`        | Commit as _fixup_ for later rebased with autosquash                                                                   |
| `g ci-rr`     | `git commit --fixup=reword:$1 ${@:2}` | Commit as _reword_ for later rebased with autosquash                                                                  |

#### Conventional Commit aliases

The `g` wrapper provides a feature called [conventional-commit] which accepts a
second argument for _type_. The described aliases below bound this argument.

| Alias command    | Equivalent **conventional-commit** command |
| ---------------- | ------------------------------------------ |
| `g cci-build`    | `git conventional-commit build`            |
| `g cci-chore`    | `git conventional-commit chore`            |
| `g cci-ci`       | `git conventional-commit ci`               |
| `g cci-docs`     | `git conventional-commit docs`             |
| `g cci-feat`     | `git conventional-commit feat`             |
| `g cci-fix`      | `git conventional-commit fix`              |
| `g cci-perf`     | `git conventional-commit perf`             |
| `g cci-refactor` | `git conventional-commit refactor`         |
| `g cci-style`    | `git conventional-commit style`            |
| `g cci-test`     | `git conventional-commit test`             |

### Advanced aliases
Contrary to the previous alias types, advanced aliases are designed to give
solution in a strict situation without taking account other type of application.
See the "Notes" section how they allow parametrisation for the underlying
**git** command!

| Alias command | Description                                        | Notes                                                                                                |
| ------------- | -------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| `g l`         | Print a coloured, compact one-liner log            | Only `--pretty=format` used, any other [git log] argument works                                      |
| `g ph-o`      | Set upstream to origin and push the current branch | Doesn't take any argument                                                                            |
| `g re-2`      | Restore both staged and unstaged changes           | Any argument is passed through to [git restore]                                                      |
| `g q-sh`      | Shows the content of a stash entry                 | An optional argument can be given and passed as index to the [git stash] _(see description section)_ |

## Features

### g
The `g` command is the starting point of all other script and provides a
convenient alias for `git`.
Calling it without arguments executes the [git status] itself if the _CWD_ is a
git repository, otherwise calls the [git help] command.

---

### conventional-commit
Creates a commit in compliance with the [Conventional Commit Message Format].

#### Alias
`cci`

#### Signature
```zsh
$ g conventional-commit <type> <scope> <message>
```

#### Arguments
- `type`: The type part of the commit message, which is [described in the
  guideline here].
- `scope`: The scope part of the commit message.
- `message`: The subject and body part of the commit message.

#### Advanced use
In order to use this feature more conveniently, it's advised to create aliases
for commonly used types in the [git config], for example:
```zsh
$ git config --global alias.cci-feat 'conventional-commit feat'
$ git config --global alias.cci-fix 'conventional-commit fix'
$ git config --global alias.cci-test 'conventional-commit test'
```

This will add new sections to the `~/.gitconfig` file with the following
content:
```gitconfig
[alias]
cci-feat = conventional-commit feat
cci-fix = conventional-commit fix
cci-test = conventional-commit test
```

_Note_: If you prefer, you can edit the config manually to achieve the same
result.

_Note 2_: Command aliases are available in the predefined git config as
[Conventional Commit aliases] too.

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

The `set-user` can turn on GPG signing for the repository too if the
`user.signingkey` config is set. Once is enabled, `set-user` will sets
`gpg.program` and `commit.gpgsign` configs too for the repository.

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
Initiates a git repository in the current directory and populated `README.md`,
`LICENSE.md` and `.gitignore` files.

By default the readme file will hold the name of the project and a link to the
license file. Defining a description as argument will result to fill it the
readme file with it.

The license will be [MIT].

To make the `.gitignore` file the command will download the content from
Toptal's [gitignore.io].

The following templates are applied by default:
- **Operating systems**: Linux, macOS, Windows
- **Editors**: JetBrains, Sublime Text, Vim, Visual Studio Code
- **Custom elements**: `[git root]/.tmp` directory, `.env` files, but negated
  any `.gitkeep` file occurrences

If a _[type]_ is also defined then the appropriate programming language will be
added to the ignore too. Currently supported languages are `java`, `node`,
`php`, `python` and `rust`.

The [switch-main] command will be also called with the create flag, ensuring the
correct branch name by default from the first commit.

#### Alias
`si`

#### Signature
```zsh
$ g super-init [type] [description]
```

#### Arguments
- `type`: The _"programming language"_ to use for the `.gitignore` file.
- `description`: Optional description for the `README.md`.

---

### switch-main
The `switch-main` command provides a clean way to change the current branch to
the default `main`. The command is created in the notion to avoid the usage of
the `master` naming for branch, which is [considered as oppressive phrasing] and
suggested to use alternatives.

#### Alias
`sw-m`

#### Signature
```zsh
$ g switch-main [-c|--create]
```

#### Arguments
- `-c|--create`: Creates the default branch. Useful during repository migration.

#### Advanced use
The default branch name is `main`, but for legacy reasons there is also an
option to modify what is considered to be the _main branch_: because **git**
also supports default branches (since 2.28.0) with [`init.defaultBranch` git
config], this command also relies on that:

```zsh
$ # in a GitHub Pages project
$ git rev-parse --abbrev-ref HEAD
feat/add-contact-info
$ git config --local init.defaultBranch gh-pages
$ g switch-main
$ git rev-parse --abbrev-ref HEAD
gh-pages
```

_Note_: This can be overwritten globally via the `git config --global` command.

## License
Available under the [MIT license].

[Abbreviation aliases]: #abbreviation-aliases
[Advanced aliases]: #advanced-aliases
[Commit aliases]: #commit-aliases
[conventional-commit]: #conventional-commit
[Conventional Commit aliases]: #conventional-commit-aliases
[Conventional Commit Message Format]: https://www.conventionalcommits.org/en/v1.0.0/#summary
[Basic aliases]: #basic-aliases
[considered as oppressive phrasing]: https://tools.ietf.org/id/draft-knodel-terminology-00.html#rfc.section.1.1
[Features]: #features
[g]: #g-1
[git]: https://git-scm.com
[git clone]: https://git-scm.com/docs/git-clone
[git commit]: https://git-scm.com/docs/git-commit
[git commit fixup]: https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---fixupamendrewordltcommitgt
[git config]: https://git-scm.com/docs/git-config
[git global config]: https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
[git help]: https://git-scm.com/docs/git-help
[git log]: https://git-scm.com/docs/git-log
[git restore]: https://git-scm.com/docs/git-restore
[git stash]: https://git-scm.com/docs/git-stash
[git stash push --staged]: https://git-scm.com/docs/git-stash#Documentation/git-stash.txt---staged
[git status]: https://git-scm.com/docs/git-status
[git switch]: https://git-scm.com/docs/git-switch
[rebased with autosquash]: https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt---autosquash
[git-set-user]: #set-user
[GitHub Pages]: https://help.github.com/en/github/working-with-github-pages/creating-a-github-pages-site#creating-a-repository-for-your-site
[gitignore.io]: https://www.toptal.com/developers/gitignore
[`init.defaultBranch` git config]: https://git-scm.com/docs/git-config#Documentation/git-config.txt-initdefaultBranch
[Install]: #install
[License]: #license
[MIT]: https://opensource.org/licenses/MIT
[MIT license]: LICENSE.md
[Predefined git config]: #predefined-git-config
[Prerequirements]: #prerequirements
[set-user]: #set-user
[Steps]: #steps
[super-init]: #super-init
[switch-main]: #switch-main
[url match functionality]: https://git-scm.com/docs/git-config#Documentation/git-config.txt---get-urlmatchnameURL
[zsh]: http://www.zsh.org/
