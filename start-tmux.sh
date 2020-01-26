#!/bin/bash

SESSION_NAME="root"
tmux has-session -t $SESSION_NAME &> /dev/null

if [ $? != 0 ]
 then
    tmux new-session -s $SESSION_NAME -n bld -d -c ~/.dotFiles -P \; split-window -h -c ~/.dotFiles \; split-window -v -c ~/Downloads
    tmux select-pane -t:.0 \; split-window -v -c /mnt/NAS/video
    tmux new-window -n src -c ~/.dotFiles -P \; split-window -h -c ~/.dotFiles
    tmux new-window -n video -P -c /mnt/NAS/video
fi

tmux attach -t $SESSION_NAME
