#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function symlink() {
  src="$1"
  dest="$2"

  if [ -e "$dest" ]; then
    if [ -L "$dest" ]; then
      # Already symlinked -- I'll assume correctly.
      return
    else
      # Rename files with a ".old" extension.
      echo "$dest already exists, renaming to $dest.old"
      backup="$dest.old"
      if [ -e "$backup" ]; then
        echo "Error: "$backup" already exists. Please delete or rename it."
        exit 1
      fi
      mv -v "$dest" "$backup"
    fi
  fi
  ln -sf "$src" "$dest"
}

function createSymlinks() {
    OS=`uname`

    if [[ "${OS}" == "Darwin" ]]; then
        symlink "$basedir/.vim/vimrc_mac" "$HOME/.vimrc"
    else
        symlink "$basedir/.vim/vimrc_main" "$HOME/.vimrc"
    fi
}

function doIt() {
    rsync --exclude ".git/" \
        --exclude ".DS_Store" \
        --exclude ".macos" \
        --exclude "bootstrap.sh" \
        --exclude "README.md" \
        --exclude "LICENSE-MIT.txt" \
        -avh --no-perms . ~;
    source ~/.bash_profile;

    createSymlinks;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt;
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt;
    fi;
fi;
unset doIt;