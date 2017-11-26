@echo off
setlocal

set PATH=%PATH%;%~dp0..\libexec

if "x%1"=="x" (
    (
        echo Usage: %~n0 ^<command^> [^<args^>]
        echo;
        echo Some useful dcvm commands are:
        echo    list         List all available versions
        echo    install      Install a D compiler
        echo    uninstall    Uninstall a specific D compiler
        echo    versions     List all D compiler available to dcm
        echo    exec         Executable program of a specific D compiler
        exit /b 1
    ) 1>&2
)

set CMD=%~n0-%1

for /f "usebackq tokens=1*" %%I in ('%*') do (
    set ARGS=%%J
)

for %%I in (%CMD%.com %CMD%.exe %CMD%.bat %CMD%.cmd %CMD%.vbs %CMD%.js %CMD%.wsf %CMD%.ps1) do (
    if exist %%~$path:I set EXEC_PATH=%%~$path:I
)

if "x%EXEC_PATH%"=="x" (
    echo %1 command not found. 1>&2
    exit /b 1
)

if "%EXEC_PATH:~-4%"==".ps1" (
    powershell -ExecutionPolicy Unrestricted %EXEC_PATH% %ARGS%
) else (
    %EXEC_PATH% %ARGS%
)
exit /b %ERRORLEVEL%

endlocal
