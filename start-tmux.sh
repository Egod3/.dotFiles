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
  tmux split-window -h -c ~/.dotFiles

  # 1
  tmux new-window -n png_sekrt -c /mnt/NAS/data/git/learning/png_sekrt
  tmux split-window -h -c /mnt/NAS/data/git/learning/png_sekrt/src

  # 2
#  tmux new-window -n rename_media -c /mnt/NAS/data/git/tools/rename_media
#  tmux split-window -h -c /mnt/NAS/data/git/tools/rename_media/src

  # 2
  tmux new-window -n stm32 -c /mnt/NAS/data/git/rust_embd/apps/stm32-rs
  tmux split-window -h -c /mnt/NAS/data/git/rust_embd/apps/stm32-rs
  tmux selectp -t 0
  tmux split-window -v -c /mnt/NAS/data/git/rust_embd/apps/stm32-rs

  # 3
  tmux new-window -n si70xx -c /mnt/NAS/data/git/rust_embd/libs/si70xx
  tmux split-window -h -c /mnt/NAS/data/git/rust_embd/libs/si70xx

  # 4
  tmux new-window -n tockOS -c /mnt/NAS/data/git/rust_embd/oses/tock
  tmux split-window -h -c /mnt/NAS/data/git/rust_embd/oses/tock

  # 5
  tmux new-window -n video -c /mnt/NAS/video

fi

tmux attach -t $SESSION_NAME
