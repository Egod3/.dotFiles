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
  tmux new-window -n hexdump -c /mnt/NAS/data/git/tools/hd
  tmux split-window -h -c         /mnt/NAS/data/git/tools/hd/src
  # 2
#  tmux new-window -n rename_media -c /mnt/NAS/data/git/tools/rename_media
#  tmux split-window -h -c            /mnt/NAS/data/git/tools/rename_media/src
  # 2
  tmux new-window -n stm32 -c /mnt/NAS/data/git/rust_embd/apps/stm32-rs
  tmux split-window -h -c     /mnt/NAS/data/git/rust_embd/apps/stm32-rs
  # 3
  tmux new-window -n si70xx -c /mnt/NAS/data/git/rust_embd/libs/si70xx
  tmux split-window -h -c      /mnt/NAS/data/git/rust_embd/libs/si70xx
  # 4
  ### Remember to run this command in the below windows ###
  # source ~/zephyrproject/.venv/bin/activate
  tmux new-window -n zephyr -c /mnt/NAS/data/git/rust_embd/oses/zephyrproject
  tmux split-window -h -c      /mnt/NAS/data/git/rust_embd/oses/zephyrproject
  tmux selectp -t 0
  tmux split-window -v -c      /mnt/NAS/data/git/rust_embd/oses/zephyrproject
  # 5
  tmux new-window -n video -c /mnt/NAS/video
  # 6
  tmux new-window -n rustos -c /mnt/NAS/data/git/rust_embd/oses/rustos
  tmux split-window -h -c /mnt/NAS/data/git/rust_embd/oses/rustos

fi

tmux attach -t $SESSION_NAME
