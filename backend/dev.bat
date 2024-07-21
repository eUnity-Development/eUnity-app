@echo off

REM Set the HOST_WORKING_DIR environment variable to the current directory
setlocal


:: Define the path to your .env file
set "ENV_FILE=.env"

:: Check if the .env file exists
if not exist "%ENV_FILE%" (
    echo The .env file does not exist.
    exit /b 1
)

:: Define the current directory
set "CURRENT_DIR=%cd%"

:: Create a temporary file for updated .env content
set "TEMP_FILE=%ENV_FILE%.tmp"

:: Update or add HOST_WORKING_DIR in the .env file
(
    setlocal enabledelayedexpansion
    set "seenHostWorkingDir=0"

    for /f "usebackq tokens=1,* delims==" %%A in ("%ENV_FILE%") do (
        if "%%A"=="HOST_WORKING_DIR" (
            if "!seenHostWorkingDir!"=="0" (
                echo HOST_WORKING_DIR=%CURRENT_DIR%
                set "seenHostWorkingDir=1"
            )
        ) else (
            echo %%A=%%B
        )
    )
    
    REM Ensure HOST_WORKING_DIR is added if it wasn't found
    if "!seenHostWorkingDir!"=="0" (
        echo HOST_WORKING_DIR=%CURRENT_DIR%
    )

    endlocal
) > "%TEMP_FILE%"

:: Replace the old .env file with the new one
move /y "%TEMP_FILE%" "%ENV_FILE%"

echo Updated HOST_WORKING_DIR in %ENV_FILE% to %CURRENT_DIR%




REM Define source and destination paths
set "SOURCE=%USERPROFILE%\.ssh\id_rsa"
set "DESTINATION=%CD%\.ssh\id_rsa"

REM Check if the SSH key already exists
if not exist "%SOURCE%" (
    echo SSH key not found. Generating a new key...
    
    REM Generate a new SSH key
    ssh-keygen -t rsa -b 4096 -f "%SOURCE%" -N ""

    REM Check if key generation was successful
    if errorlevel 1 (
        echo Failed to generate SSH key.
        exit /b 1
    )
) else (
    echo SSH key already exists.
)

REM Create the .ssh directory in the current directory if it doesn't exist
if not exist "%CD%\.ssh\" mkdir "%CD%\.ssh\"

REM Copy the id_rsa file to the destination
copy /Y "%SOURCE%" "%DESTINATION%"

REM Notify the user
echo Key has been copied to %DESTINATION%


endlocal

REM Run Docker Compose with the updated environment variable
docker pull desarso/eunity-dev:latest
