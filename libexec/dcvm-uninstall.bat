@echo off

if "x%1"=="x" (
	echo Usage: dcvm uninstall ^<version^> 1>&2
	exit /b 1
)

for /f "usebackq tokens=1*" %%I in ('%*') do (
    set ARGS=%%J
)

rmdir /s /q %~dp0..\dmd\%1
