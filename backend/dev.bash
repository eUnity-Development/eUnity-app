#!/bin/bash

# Get the current directory
CURRENT_DIR="$(pwd)"

# Define the path to your .env file
ENV_FILE=".env"

# Check if the .env file exists
if [[ ! -f "$ENV_FILE" ]]; then
  echo "The .env file does not exist."
  exit 1
fi

# Create a temporary file for updated .env content
TEMP_FILE="${ENV_FILE}.tmp"

# Track if HOST_WORKING_DIR has been added
added_host_working_dir=false

# Update or add HOST_WORKING_DIR in the .env file
{
  while IFS='=' read -r key value; do
    if [[ "$key" == "HOST_WORKING_DIR" ]]; then
      if [[ "$added_host_working_dir" == false ]]; then
        echo "HOST_WORKING_DIR=$CURRENT_DIR"
        added_host_working_dir=true
      fi
    else
      echo "$key=$value"
    fi
  done < "$ENV_FILE"

  # Add HOST_WORKING_DIR if it was not present
  if [[ "$added_host_working_dir" == false ]]; then
    echo "HOST_WORKING_DIR=$CURRENT_DIR"
  fi
} > "$TEMP_FILE"

# Replace the old .env file with the new one
mv "$TEMP_FILE" "$ENV_FILE"

echo "Updated HOST_WORKING_DIR in $ENV_FILE to $CURRENT_DIR"

SOURCE="$HOME/.ssh/id_rsa"
DESTINATION="./.ssh/id_rsa"

# Check if the SSH key already exists
if [ ! -f "$SOURCE" ]; then
  echo "SSH key not found. Generating a new key..."
  
  # Generate a new SSH key
  ssh-keygen -t rsa -b 4096 -f "$SOURCE" -N ""

  if [ $? -ne 0 ]; then
    echo "Failed to generate SSH key."
    exit 1
  fi
else
  echo "SSH key already exists."
fi

# Create the .ssh directory in the current directory if it doesn't exist
mkdir -p "$(dirname "$DESTINATION")"

# Copy the id_rsa file to the destination
cp "$SOURCE" "$DESTINATION"

# Notify the user
echo "Key has been copied to $DESTINATION"

# Run Docker Compose with the updated environment variable
docker pull desarso/eunity-dev:latest
