#!/usr/bin/env bash
# GPS-only drop at 15 m/s: the canister misses into the water
cd "$(dirname "$0")" && source .venv/bin/activate
PY=python; [ "$(uname)" = "Darwin" ] && PY=mjpython   # macOS: the MuJoCo viewer needs mjpython
$PY src/flood_relief_drop_sim.py --view --controller baseline --wind 15
