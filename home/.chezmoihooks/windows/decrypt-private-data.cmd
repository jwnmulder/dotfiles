@echo off
setlocal enabledelayedexpansion

rem Cleanup stale files
for /r "%CHEZMOI_WORKING_TREE%\home\.chezmoidata" %%f in (tmp*) do (
    del "%%f"
)

if exist "%USERPROFILE%"\.config\chezmoi\key.txt (

    for /r "%CHEZMOI_WORKING_TREE%\home\.chezmoidata" %%f in (.*.yaml.age) do (

        if exist "%%f" (

            set "output_filename=%%~nf"
            set "output_filename=tmp!output_filename:.age=!"

            set "output_file=%CHEZMOI_WORKING_TREE%\home\.chezmoidata\!output_filename!"

            %CHEZMOI_EXECUTABLE% decrypt "%%f" > "!output_file!"
        )
    )
)

endlocal
