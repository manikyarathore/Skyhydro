#!/usr/bin/env bash
# Vision-guided drop, 10 m/s crosswind
cd "$(dirname "$0")" && source .venv/bin/activate
PY=python; [ "$(uname)" = "Darwin" ] && PY=mjpython   # macOS: the MuJoCo viewer needs mjpython
$PY src/flood_relief_drop_sim.py --view
