#!/bin/bash

# Take in the session name, used for testing changes
if [[ $1 != "" ]]
then
  SESSION_NAME=$1
else
  SESSION_NAME="flm"
fi
tmux has-session -t $SESSION_NAME &> /dev/null
ret=$?

echo "has-session returned: $ret"
echo "Attempting to create/attach to session $SESSION_NAME"

FLM_ROOT=/workspace/flm
HEDSCAN_ROOT=$FLM_ROOT/hedscan
PYTHON_VENV_PATH=~/.venv-uv/bin/activate

pushd /workspace

if [ $ret -eq 1 ]; then
  # 0
  tmux -2 new -s $SESSION_NAME -n workspace -d -c /workspace
  tmux split-window -h                         -c /workspace
  if [[ "$SESSION_NAME" == "flm" ]]; then
    # 1
    tmux new-window -n hs-utils                -c $HEDSCAN_ROOT/hedscan-utils
    tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-utils
    tmux selectp -t 0
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-utils
    tmux send-keys -t flm:1.0 "source $PYTHON_VENV_PATH" C-m
    tmux send-keys -t flm:1.1 "source $PYTHON_VENV_PATH" C-m
    tmux send-keys -t flm:1.2 "source $PYTHON_VENV_PATH" C-m
    # 2
    tmux new-window -n hs-server               -c $HEDSCAN_ROOT/hedscan-server
    tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-server
    tmux selectp -t 0
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-docker-server
    # 3
    tmux new-window -n hs-python               -c $HEDSCAN_ROOT/hedscan-python
    tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-python
    tmux selectp -t 0
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-python
    tmux send-keys -t flm:3.0 "source $PYTHON_VENV_PATH" C-m
    tmux send-keys -t flm:3.1 "source $PYTHON_VENV_PATH" C-m
    tmux send-keys -t flm:3.2 "source $PYTHON_VENV_PATH" C-m
    # 4
    tmux new-window -n hs-db                   -c $HEDSCAN_ROOT/hedscan-db
    tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-db
    tmux selectp -t 0
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-db
    tmux send-keys -t flm:4.0 "source $PYTHON_VENV_PATH" C-m
    tmux send-keys -t flm:4.1 "source $PYTHON_VENV_PATH" C-m
    tmux send-keys -t flm:4.2 "source $PYTHON_VENV_PATH" C-m
    # 5
    tmux new-window -n hs-web                  -c $HEDSCAN_ROOT/hedscan-web
    tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-web
    tmux selectp -t 0
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-web
    tmux send-keys -t flm:5.0 "source $PYTHON_VENV_PATH" C-m
    tmux send-keys -t flm:5.1 "source $PYTHON_VENV_PATH" C-m
    tmux send-keys -t flm:5.2 "source $PYTHON_VENV_PATH" C-m
    # 6 - hedscan-sensor-tune
    tmux new-window -n  hs-sensor-tune         -c $HEDSCAN_ROOT/hedscan-sensor-tune
    tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-sensor-tune
    tmux selectp -t 0
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-sensor-tune
    tmux send-keys -t flm:6.0 "source $PYTHON_VENV_PATH" C-m
    tmux send-keys -t flm:6.1 "source $PYTHON_VENV_PATH" C-m
    tmux send-keys -t flm:6.2 "source $PYTHON_VENV_PATH" C-m
    # 7 - hedscan-core
    tmux new-window -n hs-core                 -c $HEDSCAN_ROOT/hedscan-core
    tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-core
    tmux selectp -t 0
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-core
    # 8 - hedscan-api
    tmux new-window -n hs-api                  -c $HEDSCAN_ROOT/hedscan-api
    tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-api
    tmux selectp -t 0
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-api
    # 9
    ### Remember to run this command in the below windows - $ setup_west_ptc ###
    tmux new-window -n ptc                     -c /workspace/hedscan/ptc-firmware
    tmux split-window -h                       -c /workspace/hedscan/ptc-firmware
    tmux selectp -t 0
    tmux split-window -v                       -c /workspace/hedscan/ptc-firmware
    # 9
    tmux new-window -n hs-yocto                -c $HEDSCAN_ROOT/hedscan-yocto-build
    tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-yocto-build
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-yocto-build/layers/meta-hedscan
    tmux selectp -t 0
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-yocto-build
    # 10
    tmux new-window -n hs-mliss                -c $HEDSCAN_ROOT/hedscan-server
    tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-server
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-server
    tmux selectp -t 0
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-server
    # 11
    tmux new-window -n hs-fw-bin               -c $HEDSCAN_ROOT/hedscan-firmware-bin
    tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-firmware-bin
    # 12
    tmux new-window -n fl-server               -c $HEDSCAN_ROOT
    tmux split-window -h                       -c $HEDSCAN_ROOT
  else
    echo "unknown session name ($SESSION_NAME), nothing to do"
    popd
    exit 0
  fi
fi

tmux attach -t $SESSION_NAME

popd
exit 0
