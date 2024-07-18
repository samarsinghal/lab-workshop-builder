#!/bin/bash

# Define the target portal name and kubeconfig path
KUBECONFIG_PATH="$HOME/uploads/kubeconfig"

cd ~/exercises/$NEW_WORKSHOP_NAME

# List existing portals
EXISTING_PORTALS=$(educates list-portals | awk 'NR>2 {print $1}')

# Check if the target portal exists
if echo "$EXISTING_PORTALS" | grep -q "$TARGET_PORTAL"; then
    echo "Portal '$TARGET_PORTAL' already exists. Skipping deployment."
else
    echo "Portal '$TARGET_PORTAL' does not exist. Deploying portal..."
    
    # Construct the portal deployment command
    DEPLOY_PORTAL_COMMAND="educates deploy-portal"

    # Check if kubeconfig file exists
    if [ -f "$KUBECONFIG_PATH" ]; then
        DEPLOY_PORTAL_COMMAND="$DEPLOY_PORTAL_COMMAND --kubeconfig=$KUBECONFIG_PATH"
    fi

    # Check if PORTAL_PASSWORD environment variable is set
    if [ -n "$PORTAL_PASSWORD" ]; then
        DEPLOY_PORTAL_COMMAND="$DEPLOY_PORTAL_COMMAND --password=$PORTAL_PASSWORD"
    fi

    # Execute the portal deployment command
    # echo "Executing: $DEPLOY_PORTAL_COMMAND"
    $DEPLOY_PORTAL_COMMAND
fi

# Construct the publish workshop command
PUBLISH_WORKSHOP_COMMAND="educates publish-workshop"

# Check if IMAGE_REPOSITORY, REGISTRY_USERNAME, and REGISTRY_PASSWORD environment variables are set
if [ -n "$IMAGE_REPOSITORY" ]; then
    PUBLISH_WORKSHOP_COMMAND="$PUBLISH_WORKSHOP_COMMAND --image-repository=$REGISTRY_URL/$REGISTRY_USERNAME"
fi

if [ -n "$REGISTRY_USERNAME" ]; then
    PUBLISH_WORKSHOP_COMMAND="$PUBLISH_WORKSHOP_COMMAND --registry-username=$REGISTRY_USERNAME"
fi

if [ -n "$REGISTRY_PASSWORD" ]; then
    PUBLISH_WORKSHOP_COMMAND="$PUBLISH_WORKSHOP_COMMAND --registry-password=$REGISTRY_PASSWORD"
fi
# Execute the publish workshop command
echo "Executing: $PUBLISH_WORKSHOP_COMMAND"
$PUBLISH_WORKSHOP_COMMAND

# Construct the deploy workshop command
DEPLOY_WORKSHOP_COMMAND="educates deploy-workshop --overtime=30m  --overdue=20m --reserved=1 --initial=1"


# Check if kubeconfig file exists
if [ -f "$KUBECONFIG_PATH" ]; then
    DEPLOY_WORKSHOP_COMMAND="$DEPLOY_WORKSHOP_COMMAND --kubeconfig=$KUBECONFIG_PATH"
fi
if [ -n "$TARGET_PORTAL" ]; then
    DEPLOY_WORKSHOP_COMMAND="$DEPLOY_WORKSHOP_COMMAND --portal=$TARGET_PORTAL"
fi

# Execute the deploy workshop command
echo "Executing: $DEPLOY_WORKSHOP_COMMAND"
$DEPLOY_WORKSHOP_COMMAND


