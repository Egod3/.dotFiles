#!/bin/bash

SESSION_NAME="root"
tmux has-session -t $SESSION_NAME &> /dev/null

#echo "has-session returned: $?"

if [ $? != 0 ]
  then
  tmux -2v new-session -s $SESSION_NAME -n bld -d -c  ~/.dotFiles \; split-window -h -c ~/.dotFiles
  tmux new-window -n src -c /mnt/NAS/data/git/learning/png_sekrt/src \; split-window -h -c /mnt/NAS/data/git/learning/png_sekrt/src
  tmux new-window -n video -c /mnt/NAS/video
  tmux new-window -n programming -c /mnt/NAS/data/git/tools/rename_media \; split-window -h -c /mnt/NAS/data/git/tools/rename_media
  tmux new-window -n calcualtor -c ~/
fi

tmux attach -t $SESSION_NAME
