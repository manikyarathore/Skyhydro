@echo off
REM Quick one-time setup for RUNNING the simulations (no CUDA download; the AI pilot runs fine on the CPU).
REM Needs Python 3.11 or 3.12 (64-bit) with "Add python.exe to PATH" ticked.
cd /d "%~dp0"
where py >nul 2>nul && (set PY=py -3) || (set PY=python)
if not exist .venv %PY% -m venv .venv || goto :err
call .venv\Scripts\activate.bat || goto :err
python -m pip install --upgrade pip
pip install -r requirements.txt || goto :err
cd environment
python scene_generator.py --houses 5 --seed 1 --output scene_flood.xml || goto :err
cd ..
echo.
echo Setup done. Double-click any demo_*.bat file.
pause
goto :eof
:err
echo SETUP FAILED - see the error above.
pause
exit /b 1
