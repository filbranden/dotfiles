#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

readonly topdir=$(git rev-parse --show-toplevel)
readonly backup_timestamp=$(date +%Y%m%dT%H%M%S)

backup_file () {
    declare fname=$1
    if [[ -e "${fname}" ]] ; then
        mkdir -p ~/.BACKUP/"${backup_timestamp}_dotfiles"
        mv "${fname}" ~/.BACKUP/"${backup_timestamp}_dotfiles/"
    fi
}

symlink () {
    declare src=$1
    declare dst=$2
    # Back up file, if it exists.
    backup_file "${dst}"
    # Create parent directory, if needed.
    declare parent
    parent=$(dirname "${dst}")
    mkdir -p "${parent}"
    # Make the symlink relative, use `ln -r` when available.
    ln -snr "${src}" "${dst}"
}

# Vim setup, compatible with both Vim and NeoVim.
symlink "${topdir}/vim" ~/.config/nvim
symlink ~/.config/nvim ~/.vim
symlink ~/.vim/init.vim ~/.vimrc
# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install plugins
vim -c PlugInstall -c qa

# Tmux setup.
symlink "${topdir}/tmux/tmux.conf" ~/.tmux.conf

# Git setup, use a ~/.config/git to store a global gitignore file.
symlink "${topdir}/git" ~/.config/git
symlink ~/.config/git/gitconfig ~/.gitconfig

# Bash setup, source snippet file.
# TODO: Have a global bashrc to source in the repo, instead.
grep -q bashrc_snippet ~/.bashrc 2>/dev/null || {
    backup_file ~/.bashrc
    {   echo ''
        echo '# Source bashrc snippet from dotfiles repository.'
        snippet_relpath=$(realpath --relative-to="$HOME" "${topdir}/bash/bashrc_snippet.sh")
        snippet_relpath=$(printf %q "${snippet_relpath}")
        echo ". ${snippet_relpath}"
    } >>~/.bashrc
}

# Sort order, case sensitive, include dotfiles first.
symlink "${topdir}/bash/i18n" ~/.i18n
