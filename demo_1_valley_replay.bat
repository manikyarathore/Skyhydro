@echo off
REM Survey scan + the trained AI pilot's recorded missions in the 3D flood valley
cd /d "%~dp0"
call .venv\Scripts\activate.bat
python simulate.py --replay
pause
