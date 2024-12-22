@echo off

set HOOKS_BASE_DIR=%~dp0

call %HOOKS_BASE_DIR%/windows/decrypt-age-key.cmd
