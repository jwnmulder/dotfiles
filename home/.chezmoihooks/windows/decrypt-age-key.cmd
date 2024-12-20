@echo off

IF NOT EXIST "%USERPROFILE%\.config\chezmoi\key.txt" (
    mkdir "%USERPROFILE%\.config\chezmoi" 2>NUL

    echo "Requesting decryption of age key. Please enter password"

    %CHEZMOI_EXECUTABLE% age decrypt --output "%USERPROFILE%\.config\chezmoi\key.txt" --passphrase "%CHEZMOI_WORKING_TREE%\home\.data\key.txt.age"
    IF %ERRORLEVEL% NEQ 0 (
        exit /b %ERRORLEVEL%
    )
)
