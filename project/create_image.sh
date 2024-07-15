#!/bin/bash

# Check if the Dockerfile exists in the target directory
if [ ! -e ~/exercises/$NEW_WORKSHOP_NAME/Dockerfile ]; then
    # Copy the Dockerfile from the temporary directory
    cp -u ~/project/Dockerfile ~/exercises/$NEW_WORKSHOP_NAME/Dockerfile
fi
