# g
a (very) simple git helper

## Features

### g
The `g` command is the starting point of all other script and provides a
 convenient alias for `git`.
Calling it without arguments executes the `git status` itself if the _CWD_ is a
 git repository, otherwise calls the `git --help` command.

### cd
Similarly to the built-in `cd` command, this changes the current directory too
 but it jumps to a directory relative to the git root. It can be handy if your
 project is several level deep and have to change directory very often to an
 upper level folder (eg.: `dist`, `node_modules`).

### take
Take is a wrapper around [git clone] but by default clones the submodules too.
 The other feature _take_ provides is to change directory into the newly cloned
 repository, like [oh-my-zsh's take].

**Alias**: `ta`

**Signature**:
```
g take <repository_url> [directory]
```

**Arguments**:
- `repository_url`: The pulled repository's url
- `directory`: Optional, the output directory where to clone

## Install

1. Clone the repositoy to a desired folder
```zsh
git clone git@github.com:pcdevil/g.git ~/.g
```

2. Bootstrap it in your `.zshrc`
```zsh
# Export the destionation folder as G_DIR variable
export G_DIR=$HOME/.g
# Load the init script of g
source $G_DIR/g.plugin.zsh
```

## License
Available under the [MIT license](LICENSE.md).

[git clone]: https://git-scm.com/docs/git-clone
[oh-my-zsh's take]: https://github.com/robbyrussell/oh-my-zsh/wiki/Cheatsheet
