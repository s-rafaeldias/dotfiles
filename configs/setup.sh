#!/bin/bash

for dir in */; do
    config="${dir%/}"
    if [ $1 == "-f" ]; then
        echo "Destowing '$config'..."
        stow -D $config -t $HOME
    fi
    echo "Stowing '$config'..."
    stow $config -t $HOME

    echo
done
