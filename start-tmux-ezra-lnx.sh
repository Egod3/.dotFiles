#!/bin/bash

# Take in the session name, used for testing changes
if [[ $1 != "" ]]
then
  SESSION_NAME=$1;
else
  SESSION_NAME="root"
fi
tmux has-session -t $SESSION_NAME &> /dev/null
#status=$(tmux has-session -t $SESSION_NAME &> /dev/null)
#echo "tmux has-session returned: $status"

#if [ $status != 0 ]
if [ $? != 0 ]
  then
  # 0
  tmux -2 new-session -s $SESSION_NAME -n dotFiles -d -c    ~/.dotFiles
  tmux split-window -h -c                                   ~/.dotFiles
  # 1
  tmux new-window -n stm32 -c                               ~/git/stm32-rs
  tmux split-window -h -c                                   ~/git/stm32-rs
  tmux selectp -t 0
  tmux split-window -v -c                                   ~/git/stm32-rs
  tmux split-window -v -c                                   ~/git/stm32-rs
  # 2
  tmux new-window -n zephyr-rust -c                         ~/git/ws-app
  tmux split-window -h -c                                   ~/git/ws-app
  tmux selectp -t 0
  tmux split-window -v -c                                   ~/git/ws-app
  # 3
  tmux new-window -n hexdump -c                             ~/git/tools/hd
  tmux split-window -h -c                                   ~/git/tools/hd
  tmux selectp -t 0
  tmux split-window -v -c                                   ~/git/tools/hd
  # 4
  tmux new-window -n char-sheet -c                          ~/git/tools/char-sheet
  tmux split-window -h        -c                            ~/git/tools/char-sheet
  tmux selectp -t 0
  tmux split-window -v        -c                            ~/git/tools/char-sheet
  # 5
  tmux new-window -n mcuboot-rs -c                          ~/git/mcuboot-rs
  tmux split-window -h -c                                   ~/git/mcuboot-rs
  # 6
  tmux new-window -n bash -c                                ~

fi

tmux attach -t $SESSION_NAME
