# g
a (very) simple git helper

## Features

### g
The `g` command is the starting point of all other script and provides a
 convenient alias for `git`.
Calling it without arguments executes the `git status` itself if the _CWD_ is a
 git repository, otherwise calls the `git --help` command.

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
