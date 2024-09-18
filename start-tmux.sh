#!/usr/bin/bash

# Check the host name and then run the hostname appriopriate start script
hostname=$(hostname)

if [ -f ~/.dotFiles/start-tmux-$hostname.sh ]; then
  ~/.dotFiles/start-tmux-$hostname.sh $1
else
  echo "file ~/.dotFiles/start-tmux-$hostname.sh not found"
fi
