#!/usr/bin/env bash
# Low battery: the drone cancels the delivery and returns
cd "$(dirname "$0")" && source .venv/bin/activate
PY=python; [ "$(uname)" = "Darwin" ] && PY=mjpython   # macOS: the MuJoCo viewer needs mjpython
$PY src/flood_relief_drop_sim.py --view --battery-soc 0.27
