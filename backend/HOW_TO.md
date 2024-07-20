# How to run the backend with Docker

## 0-Make sure your .env is correct

## 1-Install Docker Desktop

    https://www.docker.com/products/docker-desktop/

## 2-Enable/Install wsl

    Open Powershell as administrator
    Type "wsl --install"

## 3-Run docker compose command

    docker compose up -d

Docker compose will run both mongodb and valkey for you. It handles all dependencies.

## If enviroment dependencies change run:

    docker compose up --build -d

This command builds the images from scratch and it is slow, only run it if any dockerfile change.

## Small Changes

If you want to make small changes in the backend you can edit the files and then restart the server container in the the docker gui.
The files in this project sync up with the container files. Restarting the server recompiles and re-runs go.

The docker container does not have air or swag so it's not good for development. We might consider using dev containers since they would basically solve all onboarding, and everyone would have the same dev enviroment, but it's not a priority.
