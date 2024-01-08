#!/bin/bash

# Take in the session name, used for testing changes
if [[ $1 != "" ]]
then
  SESSION_NAME=$1;
else
  SESSION_NAME="root"
fi
tmux has-session -t $SESSION_NAME &> /dev/null
ret=$?

#echo "has-session returned: $?"

SCALAR_ROOT=/workspace/fli-scalar/fli-scalar_0

if [ $ret != 0 ]
  then
  # 0
  ### Remember to run this command in the below windows ###
  # source $SCALAR_ROOT/.venv/bin/activate
  tmux -2v new -s "$SESSION_NAME" -n fli-scalar -d -c $SCALAR_ROOT/cxp-zephyr-scalar-mz
  tmux split-window -h                             -c $SCALAR_ROOT/cxp-zephyr-scalar-mz
  tmux split-window -v                             -c $SCALAR_ROOT/cxp-zephyr-scalar-mz
  tmux selectp -t 0
  tmux split-window -v                             -c $SCALAR_ROOT/cxp-zephyr-scalar-mz
  # 1
  tmux new-window -n ptc-fw -c /workspace/hedscan/ptc-firmware
  tmux split-window -h      -c /workspace/hedscan/ptc-firmware
  # 2
  tmux new-window -n zephyr -c $SCALAR_ROOT/zephyr
  tmux split-window -h      -c $SCALAR_ROOT/zephyr
  tmux selectp -t 0
  tmux split-window -v      -c $SCALAR_ROOT/zephyr
  # 3
  tmux new-window -n electronics -c /workspace/electronics
  tmux split-window -h      -c /workspace/electronics
  # 4
  tmux new-window -n notes -c /workspace/notes
  tmux split-window -h     -c /workspace/notes
  # 5
  tmux new-window -n tools -c /workspace/tools
  tmux split-window -h     -c /workspace/tools
  # 6
  tmux new-window -n dotFiles -c ~/.dotFiles
  tmux split-window -h        -c ~/.dotFiles
fi

tmux attach -t $SESSION_NAME
