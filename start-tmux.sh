#!/bin/bash

SESSION_NAME="root"
tmux has-session -t $SESSION_NAME &> /dev/null

#echo "has-session returned: $?"

if [ $? != 0 ]
 then
    tmux -2v new-session -s $SESSION_NAME -n bld -d -c /mnt/NAS/data/git/scripts \; split-window -h -c /mnt/NAS/data/git/scripts \; split-window -v -c ~/Downloads
    tmux select-pane -t:.0 \; split-window -v -c /mnt/NAS/video
    tmux new-window -n src -c /mnt/NAS/data/git/tools/roll_for_initiative \; split-window -h -c /mnt/NAS/data/git/tools/roll_for_initiative \; split-window -v -c /mnt/NAS/data/git/tools/roll_for_initiative
    tmux new-window -n video -c /mnt/NAS/video
    tmux new-window -n programming -c /mnt/NAS/data/git/embedded_rust/stm32-discovery-app \; split-window -h -c /mnt/NAS/data/git/embedded_rust/stm32-discovery-app \; split-window -v -c /mnt/NAS/data/git/embedded_rust/stm32-discovery-app
    tmux new-window -n calcualtor -c ~/
fi

tmux attach -t $SESSION_NAME
