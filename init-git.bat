@echo off
chcp 65001 >nul
cd /d "%~dp0"
set "PATH=%~dp0tools\git\cmd;%~dp0tools\node;%~dp0tools\sqlite;%USERPROFILE%\tools\git\cmd;%USERPROFILE%\tools\node;%USERPROFILE%\tools\sqlite;%PATH%"
where git >nul 2>nul
if errorlevel 1 (echo Git not found & pause & exit /b 1)
if exist .git (echo Repository already exists. Commit manually. & pause & exit /b 1)
set /p "GITNAME=Your name: "
set /p "GITEMAIL=Your email: "
if not defined GITNAME exit /b 1
if not defined GITEMAIL exit /b 1
git init -b main
git config user.name "%GITNAME%"
git config user.email "%GITEMAIL%"
git add START_HERE.txt README.md .gitignore tools env.bat start-nodered.bat show-data.bat load-prepared.bat scripts init-git.bat
git commit -m "Add project structure and launch instructions"
git add sim firmware docs/originals docs/schematic.pdf docs/scheme.png docs/bom.csv docs/components.csv
git commit -m "Import supplied Arduino project and source schematics"
git add db data
git commit -m "Add SQLite schema, queries and log fixtures"
git add nodered
git commit -m "Add Node-RED log import and fault checks"
git add docs
git commit -m "Add calculations, diagrams and draft documentation"
echo These commits record packaging now, not historical development stages.
git log --oneline
pause
