#!/bin/bash

# # Fail the script on any error.
# set -e

# # Variables (ensure these are passed as environment variables).
# REPO_NAME=${REPO_NAME}
# COMMIT_MESSAGE=${COMMIT_MESSAGE}
# BRANCH_NAME=${BRANCH_NAME}
# USERNAME=${USERNAME}
# EMAIL=${EMAIL}
# ACCESS_TOKEN=${ACCESS_TOKEN}

# # Check if all required environment variables are set.
# if [ -z "$REPO_NAME" ] || [ -z "$COMMIT_MESSAGE" ] || [ -z "$BRANCH_NAME" ] || [ -z "$USERNAME" ] || [ -z "$EMAIL" ] || [ -z "$ACCESS_TOKEN" ]; then
#   echo "One or more required environment variables are missing."
#   exit 1
# fi

# # Create a new directory for the repository.
# mkdir $REPO_NAME
# cd $REPO_NAME

# Initialize a new Git repository.
git init

# Configure Git.
git config user.name "$USERNAME"
git config user.email "$EMAIL"

# # Create a new file (for example purposes).
# echo "This is a new file." > newfile.txt

# Add and commit the changes.
git add .
git commit -m "$COMMIT_MESSAGE"

# Create a new repository on GitHub.
curl -u "$USERNAME:$ACCESS_TOKEN" https://api.github.com/user/repos -d "{\"name\":\"$REPO_NAME\"}"

# Add the remote origin.
git remote add origin https://$USERNAME:$ACCESS_TOKEN@github.com/$USERNAME/$REPO_NAME.git

# Push the changes.
git push -u origin $BRANCH_NAME