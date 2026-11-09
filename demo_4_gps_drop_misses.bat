@echo off
REM GPS-only drop at 15 m/s: the canister misses into the water
cd /d "%~dp0"
call .venv\Scripts\activate.bat
python src\flood_relief_drop_sim.py --view --controller baseline --wind 15
pause
