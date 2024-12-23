@echo off

set HOOKS_BASE_DIR=%~dp0

setlocal

set "action=%~1" & shift
set "decrypt_key=false"

:parse_args
if "%~1"=="" goto :end_parse_args
if "%~1"=="--decrypt-key" set "decrypt_key=%~2" & shift & shift & goto :parse_args

echo Unknown parameter passed: %~1
exit /b 1

:end_parse_args
echo hook: action=%action%, decrypt_key=%decrypt_key%

if "%action%"=="read-source-state.pre" (
    @REM echo Running read-source-state.pre hooks...
    call %HOOKS_BASE_DIR%/windows/decrypt-age-key.cmd
    call %HOOKS_BASE_DIR%/windows/decrypt-private-data.cmd
)

if "%action%"=="init.pre" (
    @REM echo Running init.pre hooks...
    call %HOOKS_BASE_DIR%/windows/decrypt-age-key.cmd
)

endlocal
