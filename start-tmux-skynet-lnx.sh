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

if [ $ret -eq 1 ]; then
  # 0
  tmux -2 new -s $SESSION_NAME -n dotFiles -d      -c ~/.dotFiles
  tmux split-window -h                             -c ~/.dotFiles
  if [[ "$SESSION_NAME" == "flm" ]]; then
    # 1
    ### Remember to run this command in the below windows - $ setup_west_ptc ###
    tmux new-window -n ptc                           -c /workspace/hedscan/ptc-firmware
    tmux split-window -h                             -c /workspace/hedscan/ptc-firmware
    tmux selectp -t 0
    tmux split-window -v                             -c /workspace/hedscan/ptc-firmware
    # 2
    tmux new-window -n hs-yocto                      -c /workspace/yocto/hedscan/hedscan-yocto-build
    tmux split-window -h                             -c /workspace/yocto/hedscan/hedscan-yocto-build
    tmux split-window -v                             -c /workspace/yocto/hedscan/hedscan-yocto-build/layers/meta-hedscan
    tmux selectp -t 0
    tmux split-window -v                             -c /workspace/yocto/hedscan/hedscan-yocto-build
    # 3
    tmux new-window -n hs-utils                      -c $HEDSCAN_ROOT/hedscan-utils
    tmux split-window -h                             -c $HEDSCAN_ROOT/hedscan-utils
    # 4
    tmux new-window -n hs-server                     -c $HEDSCAN_ROOT/hedscan-server
    tmux split-window -h                             -c $HEDSCAN_ROOT/hedscan-server
    tmux selectp -t 0
    tmux split-window -v                             -c $HEDSCAN_ROOT/hedscan-docker-server
    # 5
    tmux new-window -n hs-core                       -c $HEDSCAN_ROOT/hedscan-core
    tmux split-window -h                             -c $HEDSCAN_ROOT/hedscan-core
    tmux selectp -t 0
    tmux split-window -v                             -c $HEDSCAN_ROOT/hedscan-docker-core
    # 6
    tmux new-window -n hs-docker-srv                 -c $HEDSCAN_ROOT/hedscan-docker-server
    tmux split-window -h                             -c $HEDSCAN_ROOT/hedscan-docker-server
    # 7
    tmux new-window -n SW-DEV                        -c $HEDSCAN_ROOT/hedscan-server
    tmux split-window -h                             -c $HEDSCAN_ROOT/hedscan-server
    tmux split-window -v                             -c $HEDSCAN_ROOT/hedscan-server
    tmux selectp -t 0
    tmux split-window -v                             -c $HEDSCAN_ROOT/hedscan-server
    # 8
    tmux new-window -n hedscan-xh                    -c $HEDSCAN_ROOT/hedscan-server
    tmux split-window -h                             -c $HEDSCAN_ROOT/hedscan-server
    tmux split-window -v                             -c $HEDSCAN_ROOT/hedscan-server
    tmux selectp -t 0
    tmux split-window -v                             -c $HEDSCAN_ROOT/hedscan-server
    # 9
    tmux new-window -n hedscan-fw-bin                 -c $HEDSCAN_ROOT/hedscan-firmware-bin
    tmux split-window -h                              -c $HEDSCAN_ROOT/hedscan-firmware-bin
    # 10
    tmux new-window -n fl-server                      -c $HEDSCAN_ROOT
    tmux split-window -h                              -c $HEDSCAN_ROOT
  else
    echo "unknown session name ($SESSION_NAME), nothing to do"
    exit 0
  fi
fi

tmux attach -t $SESSION_NAME

exit 0
