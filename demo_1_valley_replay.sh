#!/usr/bin/env bash
# Survey scan + the trained AI pilot's recorded missions in the 3D flood valley
cd "$(dirname "$0")" && source .venv/bin/activate
PY=python; [ "$(uname)" = "Darwin" ] && PY=mjpython   # macOS: the MuJoCo viewer needs mjpython
$PY simulate.py --replay
