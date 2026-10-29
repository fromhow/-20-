@echo off
chcp 65001 >nul
cd /d "%~dp0"
set "PATH=%~dp0tools\git\cmd;%~dp0tools\node;%~dp0tools\sqlite;%USERPROFILE%\tools\git\cmd;%USERPROFILE%\tools\node;%USERPROFILE%\tools\sqlite;%PATH%"
echo Loads the prepared db/load.sql, not a newly edited log. Use Node-RED for new logs.
sqlite3 -bail db/variant.db ".read db/schema.sql" ".read db/load.sql"
if errorlevel 1 (echo FAILED & pause & exit /b 1)
echo OK
pause
