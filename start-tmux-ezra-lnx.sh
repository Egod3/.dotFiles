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
  #tmux new-window -n stm32l4hal -c                          ~/git/rust_embd/libs/stm32l4xx-hal/examples
  #tmux split-window -h -c                                   ~/git/rust_embd/libs/stm32l4xx-hal/examples
  # 2
  tmux new-window -n stm32 -c                               ~/git/stm32-rs
  tmux split-window -h -c                                   ~/git/stm32-rs
  tmux selectp -t 0
  tmux split-window -v -c                                   ~/git/stm32-rs
  tmux split-window -v -c                                   ~/git/stm32-rs
  #tmux new-window -n uart-stm32 -c                          ~/git/uart-stm32
  #tmux split-window -h -c                                   ~/git/uart-stm32
  #tmux new-window -n si70xx -c                              ~/git/si70xx
  #tmux split-window -h -c                                   ~/git/si70xx
  ### Remember to run this command in the below windows - $ setup_west ###
  # 3
  tmux new-window -n zephyr-rust -c                         ~/git/ws-app
  tmux split-window -h -c                                   ~/git/ws-app
  tmux selectp -t 0
  tmux split-window -v -c                                   ~/git/ws-app
  # 4
  tmux new-window -n tcp-serial-redir -c                    ~/git/tcp-serial-redirect
  tmux split-window -h -c                                   ~/git/tcp-serial-redirect
  tmux selectp -t 0
  tmux split-window -v -c                                   ~/git/tcp-serial-redirect
  # 5
  tmux new-window -n rtic-app -c                            ~/git/rtic-app
  tmux split-window -h        -c                            ~/git/rtic-app
  tmux selectp -t 0
  tmux split-window -v        -c                            ~/git/rtic-app
  tmux split-window -v        -c                            ~/git/rtic-app
  # 6
  tmux new-window -n mcuboot-rs -c                          ~/git/mcuboot-rs
  tmux split-window -h -c                                   ~/git/mcuboot-rs
  # 7
  tmux new-window -n bash -c                                ~

fi

tmux attach -t $SESSION_NAME
