#!/usr/bin/env bash
# Quick one-time setup for RUNNING the simulations on Linux / macOS (AI pilot runs on the CPU, no CUDA download).
set -e
cd "$(dirname "$0")"
PY=${PYTHON:-python3}
[ -d .venv ] || $PY -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt
(cd environment && python scene_generator.py --houses 5 --seed 1 --output scene_flood.xml)
echo "Setup done. Run any ./demo_*.sh"
