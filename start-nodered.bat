@echo off
chcp 65001 >nul
cd /d "%~dp0"
set "PATH=%~dp0tools\git\cmd;%~dp0tools\node;%~dp0tools\sqlite;%USERPROFILE%\tools\git\cmd;%USERPROFILE%\tools\node;%USERPROFILE%\tools\sqlite;%PATH%"
where node >nul 2>nul
if errorlevel 1 (echo Node.js not found. See tools\README.txt & pause & exit /b 1)
where sqlite3 >nul 2>nul
if errorlevel 1 (echo sqlite3 not found. See tools\README.txt & pause & exit /b 1)
set "RED=%~dp0tools\nodered\node_modules\node-red\red.js"
if not exist "%RED%" set "RED=%USERPROFILE%\tools\nodered\node_modules\node-red\red.js"
if not exist "%RED%" (echo Node-RED not found. See tools\README.txt & pause & exit /b 1)
echo Open http://127.0.0.1:1880 - Ctrl+C to stop.
node "%RED%" --userDir "%~dp0.nodered" --settings "%~dp0nodered\settings.js" "%~dp0nodered\flow.json"
pause
