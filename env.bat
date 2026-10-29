@echo off
chcp 65001 >nul
cd /d "%~dp0"
set "PATH=%~dp0tools\git\cmd;%~dp0tools\node;%~dp0tools\sqlite;%USERPROFILE%\tools\git\cmd;%USERPROFILE%\tools\node;%USERPROFILE%\tools\sqlite;%PATH%"
cmd /k
