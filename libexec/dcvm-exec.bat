@echo off

if "x%1"=="x" goto usage
if "x%2"=="x" goto usage

for /f "usebackq tokens=1,2*" %%I in ('%*') do (
    set ARGS=%%K
)

for /d %%D in (%~dp0..\dmd\%1\*) do set EXEC_PATH=%%D\windows\bin\%2

%EXEC_PATH% %ARGS%
exit /b %ERRORLEVEL%

:usage
echo Usage: dcvm exec ^<version^> ^<cmd^> [^<options^>] 1>&2
exit /b 1
