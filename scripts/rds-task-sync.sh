#!/usr/bin/env bash

# Simple script to sync my tasks daily to GitHub
TASK_PATH="$HOME/.local/share/task"

pushd $TASK_PATH

git add .
git commit -m "feat(sync): auto update"
git push

popd
