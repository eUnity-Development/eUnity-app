# How to run the backend

## 0-Make sure your .env is correct

## 1-Install Docker Desktop

    https://www.docker.com/products/docker-desktop/

## 2-Enable/Install wsl

    Open Powershell as administrator
    Type "wsl --install"

## 3-Run dev.bat or dev.bash windows/mac or linux

    Should work fine if you have issues let me know

## 4-Download the dev-contaniners extension

    Then type ctrl+shift+p and type re-open in container

## 5-Type "make run" once inside the container

    The dev container serves like normal to
        port 3200

    Mongo is on 
        localhost:27018

## Video Walkthrough : https://drive.google.com/file/d/1XEyDfmLhbX1dUCJkNNnWd4aCkV0iUYZR/view?usp=sharing


## Notes

    The command "make run" will run swag init and the server with air.
    This means the server will reload whenever there are file changes which is nice for dev.

## For MAC or Linux

    if you get this error: dev.bash: line 2: $'\r': command not found
    It's a line break issue dues to windows run this
    sed -i 's/\r$//' dev.bash
    you gotta change all the line breaks from CRLF --> LF


    
## Improvements

    This seems like the easiest and most reliable way to run the backend on all the different dev enviroments. We will also be doing rolling deployments to dev branch soon so devs might be able to use that for front-end if its easier. 
