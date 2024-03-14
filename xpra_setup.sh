#!/bin/bash
xpra start :11

export DISPLAY=:11
echo "DISPLAY = $DISPLAY"
