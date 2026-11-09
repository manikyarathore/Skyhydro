@echo off
REM The trained AI pilot flies a new mission live (path checked against the trees first)
cd /d "%~dp0"
call .venv\Scripts\activate.bat
python simulate.py
pause
