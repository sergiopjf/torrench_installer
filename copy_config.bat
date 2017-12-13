@ECHO OFF

if not exist "%USERPROFILE%\.config\torrench" mkdir "%USERPROFILE%\.config\torrench"

xcopy /s /y config.ini %USERPROFILE%\.config\torrench