@echo off
REM Low battery: the drone cancels the delivery and returns
cd /d "%~dp0"
call .venv\Scripts\activate.bat
python src\flood_relief_drop_sim.py --view --battery-soc 0.27
pause
