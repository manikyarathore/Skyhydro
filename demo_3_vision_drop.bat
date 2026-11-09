@echo off
REM Vision-guided drop, 10 m/s crosswind
cd /d "%~dp0"
call .venv\Scripts\activate.bat
python src\flood_relief_drop_sim.py --view
pause
