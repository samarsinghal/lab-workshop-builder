#!/bin/bash


# Check if all required environment variables are set.
if [ -z "$NEW_WORKSHOP_NAME" ] || [ -z "$COMMIT_MESSAGE" ] || [ -z "$BRANCH_NAME" ] || [ -z "$USERNAME" ] || [ -z "$EMAIL" ] || [ -z "$ACCESS_TOKEN" ]; then
  echo "One or more required environment variables are missing."
  exit 1
fi

# Function to commit and push changes.
commit_and_push() {
  cd ~/exercises/$NEW_WORKSHOP_NAME
  git config user.name "$USERNAME"
  git config user.email "$EMAIL"
  git add .
  git commit -m "$COMMIT_MESSAGE"
  git push origin $BRANCH_NAME
}

# Check if the repository directory exists.
if [ -d "$HOME/exercises/$NEW_WORKSHOP_NAME" ]; then
  echo "Repository directory exists. Committing and pushing changes."
  commit_and_push
else
  echo "Repository directory does not exist. Please clone the repository first."
  exit 1
fi
