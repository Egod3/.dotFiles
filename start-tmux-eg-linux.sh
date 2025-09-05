#!/bin/bash

# Take in the session name, used for testing changes
if [[ $1 != "" ]]
then
  SESSION_NAME=$1
else
  SESSION_NAME="fli"
fi
tmux has-session -t $SESSION_NAME &> /dev/null
ret=$?

echo "has-session returned: $ret"
echo "Attempting to create/attach to session $SESSION_NAME"

SCALAR_ROOT=/workspace/fli-scalar/fli-scalar_0
FLI_ROOT=/workspace/fli
NQMA_ROOT=$FLI_ROOT/nqma
FLM_ROOT=/workspace/flm
HEDSCAN_ROOT=$FLM_ROOT/hedscan

pushd /workspace

if [ $ret -eq 1 ]; then
  # 0
  tmux -2 new -s $SESSION_NAME -n workspace -d -c /workspace
  tmux split-window -h                         -c /workspace
  if [[ "$SESSION_NAME" == "fli" ]]; then
    # 0
    tmux new-window -n dotFiles                -c ~/.dotFiles
    tmux split-window -h                       -c ~/.dotFiles
    # 1
    tmux new-window -n notes                   -c /workspace/notes
    tmux split-window -h                       -c /workspace/notes
    # 2
    ### Remember to run this command in the below windows - $ setup_west ###
    tmux new-window -n zephyr                  -c $SCALAR_ROOT/cxp-zephyr-scalar-mz
    tmux split-window -h                       -c $SCALAR_ROOT/cxp-zephyr-scalar-mz
    tmux split-window -v                       -c $SCALAR_ROOT/cxp-zephyr-scalar-mz/boards
    tmux selectp -t 0
    tmux split-window -v                       -c $SCALAR_ROOT/cxp-zephyr-scalar-mz/boards
    # 3
    tmux new-window -n yocto                   -c /workspace/yocto/nqma/fli-nqma-yocto-build
    tmux split-window -h                       -c /workspace/yocto/nqma/fli-nqma-yocto-build
    tmux split-window -v                       -c /workspace/yocto/nqma/fli-nqma-yocto-build/layers/meta-fli
    tmux selectp -t 0
    tmux split-window -v                       -c /workspace/yocto/nqma/fli-nqma-yocto-build/layers/meta-fli
    # 4
    tmux new-window -n fli-utils               -c $NQMA_ROOT/fli-utils
    tmux split-window -h                       -c $NQMA_ROOT/fli-utils
    tmux selectp -t 0
    tmux split-window -v                       -c $NQMA_ROOT/fli-utils
    # # 5
    # tmux new-window -n   nqma-node-service     -c /workspace/rust/nqma-node-service
    # tmux split-window -h                       -c /workspace/rust/nqma-node-service
    # tmux selectp -t 0
    # tmux split-window -v                       -c /workspace/rust/nqma-node-service
    # 5
    tmux new-window -n nqma-fw-bin             -c $NQMA_ROOT/fli-nqma-firmware-bin
    tmux split-window -h                       -c $NQMA_ROOT/fli-nqma-firmware-bin
    # 6
    tmux new-window -n nqma-provision          -c $NQMA_ROOT/fli-utils/scripts
    tmux split-window -h                       -c $NQMA_ROOT/fli-utils/scripts
    # 7
    #   - nqma-sbc-base, base-station
    tmux new-window -n nqma-sbc-base           -c ~/
    tmux split-window -h                       -c ~/
    tmux split-window -v                       -c ~/
    tmux selectp -t 0
    tmux split-window -v                       -c ~/
    # 8
    # run: setup_scalar_gui to setup python virtual env
    # to launch the GUI run: DISPLAY=:0.0 python app/app.py &
    tmux new-window -n 'FLI Recorder'          -c $NQMA_ROOT/scalar-gui
    tmux split-window -h                       -c $NQMA_ROOT/scalar-gui
    # 9
    #   fli-utils-auto - for automated fli-utils running of nqma_pfn_simple_loop.sh/py scripts
    tmux new-window -n fli-utils-auto          -c $NQMA_ROOT/fli-utils-auto
    tmux split-window -h                       -c $NQMA_ROOT/fli-utils-auto
    tmux split-window -v                       -c $NQMA_ROOT/fli-utils-auto
    tmux selectp -t 0
    tmux split-window -v                       -c $NQMA_ROOT/fli-utils-auto
    # 10
    tmux new-window -n 'logs'                  -c /workspace/logs/nqma
    tmux split-window -h                       -c /workspace/logs/nqma
  elif [[ "$SESSION_NAME" == "flm" ]]; then
    # 1
    tmux new-window -n hs-utils                -c $HEDSCAN_ROOT/hedscan-utils
    tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-utils
    tmux selectp -t 0
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-utils
    tmux send-keys -t flm:1.0 "source ~/.venv/bin/activate" C-m
    tmux send-keys -t flm:1.1 "source ~/.venv/bin/activate" C-m
    tmux send-keys -t flm:1.2 "source ~/.venv/bin/activate" C-m
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
    tmux send-keys -t flm:3.0 "source ~/.venv/bin/activate" C-m
    tmux send-keys -t flm:3.1 "source ~/.venv/bin/activate" C-m
    tmux send-keys -t flm:3.2 "source ~/.venv/bin/activate" C-m
    # 4
    tmux new-window -n hs-db                   -c $HEDSCAN_ROOT/hedscan-db
    tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-db
    tmux selectp -t 0
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-db
    tmux send-keys -t flm:4.0 "source ~/.venv/bin/activate" C-m
    tmux send-keys -t flm:4.1 "source ~/.venv/bin/activate" C-m
    tmux send-keys -t flm:4.2 "source ~/.venv/bin/activate" C-m
    # 5
    tmux new-window -n hs-web                  -c $HEDSCAN_ROOT/hedscan-web
    tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-web
    tmux selectp -t 0
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-web
    tmux send-keys -t flm:5.0 "source ~/.venv/bin/activate" C-m
    tmux send-keys -t flm:5.1 "source ~/.venv/bin/activate" C-m
    tmux send-keys -t flm:5.2 "source ~/.venv/bin/activate" C-m
    # 6
    tmux new-window -n  hs-core                -c $HEDSCAN_ROOT/hedscan-core
    tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-core
    tmux selectp -t 0
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-docker-core
    # # 7
    # tmux new-window -n hs-gui                  -c $HEDSCAN_ROOT/hedscan-gui
    # tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-gui

    # 7 - hedscan-docker-qt
    tmux new-window -n hs-docker-qt            -c $HEDSCAN_ROOT/hedscan-docker-qt
    tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-docker-qt
    tmux selectp -t 0
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-docker-qt
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
    tmux new-window -n hs-yocto                -c /workspace/yocto/hedscan/hedscan-yocto-build
    tmux split-window -h                       -c /workspace/yocto/hedscan/hedscan-yocto-build
    tmux split-window -v                       -c /workspace/yocto/hedscan/hedscan-yocto-build/layers/meta-hedscan
    tmux selectp -t 0
    tmux split-window -v                       -c /workspace/yocto/hedscan/hedscan-yocto-build
    # 10
    tmux new-window -n hs-mliss                -c $HEDSCAN_ROOT/hedscan-server
    tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-server
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-server
    tmux selectp -t 0
    tmux split-window -v                       -c $HEDSCAN_ROOT/hedscan-server
    # 11
    tmux new-window -n fl-server               -c $HEDSCAN_ROOT
    tmux split-window -h                       -c $HEDSCAN_ROOT
    # 12
    tmux new-window -n hs-fw-bin               -c $HEDSCAN_ROOT/hedscan-firmware-bin
    tmux split-window -h                       -c $HEDSCAN_ROOT/hedscan-firmware-bin
  else
    echo "unknown session name ($SESSION_NAME), nothing to do"
    popd
    exit 0
  fi
fi

tmux attach -t $SESSION_NAME

popd
exit 0
