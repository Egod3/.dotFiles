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
  tmux -2 new-session -s $SESSION_NAME -n dotFiles -d -c  ~/.dotFiles
  tmux split-window -h -c                                  ~/.dotFiles
  # 1
  tmux new-window -n char-sheet -c ~/git/tools/char-sheet
  tmux split-window -h -c          ~/git/tools/char-sheet
  # 2
  tmux new-window -n mote -c       ~/git/godot/mote-godot
  tmux split-window -h -c          ~/git/godot/mote-godot
  tmux selectp -t 0
  tmux split-window -v -c          ~/git/godot/mote-godot

fi

tmux attach -t $SESSION_NAME
