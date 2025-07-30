#!/bin/bash

# Take in the session name, used for testing changes
if [[ -z '$1' ]]
then
  SESSION_NAME=$1;
else
  SESSION_NAME="root"
fi
echo "SESSION_NAME: $SESSION_NAME"
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
  tmux new-window -n htop -c                                ~
  tmux split-window -h -c                                   ~
  tmux selectp -t 0
  tmux split-window -v -c                                   ~
fi

tmux attach -t $SESSION_NAME
