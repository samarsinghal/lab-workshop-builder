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

# Function to create a new repository.
create_repository() {
  curl -u "$USERNAME:$ACCESS_TOKEN" https://api.github.com/user/repos -d "{\"name\":\"$REPO_NAME\"}"
}

# Function to clone the repository and push changes.
clone_and_push() {
  git clone https://$USERNAME:$ACCESS_TOKEN@github.com/$USERNAME/$REPO_NAME.git
  cd $REPO_NAME
  git config user.name "$USERNAME"
  git config user.email "$EMAIL"
#   echo "This is a new file." > newfile.txt
  git add .
  git commit -m "$COMMIT_MESSAGE"
  git push origin $BRANCH_NAME
}

# Check if the repository exists.
REPO_STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" -u "$USERNAME:$ACCESS_TOKEN" https://api.github.com/repos/$USERNAME/$REPO_NAME)

if [ $REPO_STATUS -eq 200 ]; then
  echo "Repository exists. Cloning and pushing changes."
  rm -rf $REPO_NAME  
  clone_and_push
elif [ $REPO_STATUS -eq 404 ]; then
  echo "Repository does not exist. Creating repository and pushing initial commit."
  create_repository
  mkdir $REPO_NAME
  cd $REPO_NAME
  git init
  git config user.name "$USERNAME"
  git config user.email "$EMAIL"
#   echo "This is a new file." > newfile.txt
  git add .
  git commit -m "$COMMIT_MESSAGE"
  git remote add origin https://$USERNAME:$ACCESS_TOKEN@github.com/$USERNAME/$REPO_NAME.git
  git push -u origin $BRANCH_NAME
else
  echo "Failed to determine the repository status. HTTP status code: $REPO_STATUS"
  exit 1
fi