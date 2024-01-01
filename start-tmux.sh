#!/bin/bash

# Take in the session name, used for testing changes
if [[ $1 != "" ]]
then
  SESSION_NAME=$1;
else
  SESSION_NAME="root"
fi
tmux has-session -t $SESSION_NAME &> /dev/null

#echo "has-session returned: $?"

if [ $? != 0 ]
  then
  # 0
  tmux -2v new-session -s $SESSION_NAME -n dotFiles -d -c  ~/.dotFiles
  tmux split-window -h -c                                  ~/.dotFiles
  # 1
  tmux new-window -n stm32l4hal -c /mnt/NAS/data/git/rust_embd/libs/stm32l4xx-hal/examples
  tmux split-window -h -c          /mnt/NAS/data/git/rust_embd/libs/stm32l4xx-hal/examples
  # 2
  tmux new-window -n stm32 -c /mnt/NAS/data/git/rust_embd/apps/stm32-rs
  tmux split-window -h -c     /mnt/NAS/data/git/rust_embd/apps/stm32-rs
  tmux selectp -t 0
  tmux split-window -v -c     /mnt/NAS/data/git/rust_embd/apps/stm32-rs
  tmux split-window -v -c     /mnt/NAS/data/git/rust_embd/apps/stm32-rs
  # 3
  tmux new-window -n uart-stm32 -c /mnt/NAS/data/git/rust_embd/libs/uart-stm32
  tmux split-window -h -c      /mnt/NAS/data/git/rust_embd/libs/uart-stm32
  #tmux new-window -n si70xx -c /mnt/NAS/data/git/rust_embd/libs/si70xx
  #tmux split-window -h -c      /mnt/NAS/data/git/rust_embd/libs/si70xx
  # 4
  ### Remember to run this command in the below windows ###
  # source ~/zephyrproject/.venv/bin/activate
  # &
  # export ZEPHYR_TOOLCHAIN_VARIANT=/mnt/NAS/data/git/rust_embd/oses/zephyr-sdk-0.16.1
  tmux new-window -n zephyr -c /mnt/NAS/data/git/rust_embd/oses/zephyrproject
  tmux split-window -h -c      /mnt/NAS/data/git/rust_embd/oses/zephyrproject
  tmux selectp -t 0
  tmux split-window -v -c      /mnt/NAS/data/git/rust_embd/oses/zephyrproject
  # 5
  tmux new-window -n video -c /mnt/NAS/video
  # 6
  tmux new-window -n mcuboot-rs -c /mnt/NAS/data/git/rust_embd/bootloaders/mcuboot-rs
  tmux split-window -h -c /mnt/NAS/data/git/rust_embd/bootloaders/mcuboot-rs

fi

tmux attach -t $SESSION_NAME
