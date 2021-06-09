#!/bin/bash

WORKING_DIR=$(pwd)
XDG_CONFIG_HOME=$HOME/.config

# Shell files
for file in $WORKING_DIR/shell/*; do
    ln -sf $file $HOME/.$(basename $file)
done

# Fish files
ln -sf $WORKING_DIR/fish/config.fish $XDG_CONFIG_HOME/fish/config.fish

# Nvim files
NVIM_DIR=$WORKING_DIR/nvim
for file in $(find -f $NVIM_DIR/*); do
    basefile=${file:${#NVIM_DIR}}

    if [ -d $file ]; then
        mkdir -p $file
    else
        ln -sf $file $XDG_CONFIG_HOME/nvim$basefile
    fi
done
