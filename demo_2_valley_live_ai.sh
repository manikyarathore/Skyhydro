#!/usr/bin/env bash
# The trained AI pilot flies a new mission live (path checked against the trees first)
cd "$(dirname "$0")" && source .venv/bin/activate
PY=python; [ "$(uname)" = "Darwin" ] && PY=mjpython   # macOS: the MuJoCo viewer needs mjpython
$PY simulate.py
