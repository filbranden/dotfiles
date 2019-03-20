## dotfiles

These are filbranden's dotfiles.

Currently setting them up for:
 * vim
 * tmux
 * git
 * bash (though I don't really customize it much)

Use `install.sh` (or `make install`) to set up the needed symlinks to use them
from this repository.

**NOTE:** First run of `vim` (during `install.sh`) might fail since vimrc
directives depend on plug-ins that are not yet installed, so it might be
necessary to `Press ENTER` to get to install the plug-ins from there. (TODO:
Find a better solution for plug-in installation on the first run.)

