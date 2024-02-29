#!/bin/bash
xpra start :10 --bind-tcp=0.0.0.0:10000

export DISPLAY=:10
echo "DISPLAY = $DISPLAY"
