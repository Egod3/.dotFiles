#!/bin/bash

SESSION_NAME="root"
tmux has-session -t $SESSION_NAME &> /dev/null

#echo "has-session returned: $?"

if [ $? != 0 ]
  then
  tmux -2v new-session -s $SESSION_NAME -n bld -d -c  ~/.dotFiles \; split-window -h -c ~/.dotFiles
  tmux new-window -n video -c /mnt/NAS/video
  tmux new-window -n png_sekrt -c /mnt/NAS/data/git/learning/png_sekrt \; split-window -h -c /mnt/NAS/data/git/learning/png_sekrt/src
#  tmux new-window -n rename_media -c /mnt/NAS/data/git/tools/rename_media \; split-window -h -c /mnt/NAS/data/git/tools/rename_media/src
  tmux new-window -n stm32 -c /mnt/NAS/data/git/embedded_rust/apps/stm32-discovery-app \; split-window -h -c /mnt/NAS/data/git/embedded_rust/apps/stm32-discovery-app/src
  tmux new-window -n aoc-2022 -c /mnt/NAS/data/git/learning/aoc/2022/rucksack \; split-window -h -c /mnt/NAS/data/git/learning/aoc/2022/rucksack/src
  tmux new-window -n calcualtor -c ~/
fi

tmux attach -t $SESSION_NAME
