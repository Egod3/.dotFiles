#!/bin/bash

SESSION_NAME="root"
tmux has-session -t $SESSION_NAME &> /dev/null

#echo "has-session returned: $?"

if [ $? != 0 ]
 then
    tmux new-session -s $SESSION_NAME -n bld -d -c /mnt/NAS/data/git/scripts \; split-window -h -c /mnt/NAS/data/git/scripts \; split-window -v -c ~/Downloads
    tmux select-pane -t:.0 \; split-window -v -c /mnt/NAS/video
    tmux new-window -n src -c /mnt/NAS/data/git/scripts \; split-window -h -c /mnt/NAS/data/git/scripts  \; split-window -v -c ~/.dotfiles
    tmux new-window -n video -c /mnt/NAS/video
    tmux new-window -n programming -c /mnt/NAS/data/git/learning/leet-code \; split-window -h -c /mnt/NAS/data/git/learning/leet-code
fi

tmux attach -t $SESSION_NAME
