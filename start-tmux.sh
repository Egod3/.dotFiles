#!/bin/bash

SESSION_NAME="root"
tmux has-session -t $SESSION_NAME &> /dev/null

if [ $? != 0 ]
 then
    tmux new-session -s $SESSION_NAME -n bld -d -P
    tmux new-window -n src -P \; split-window -h
    tmux new-window -n video -P -c /mnt/NAS/video
fi

tmux attach -t $SESSION_NAME
