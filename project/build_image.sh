    cd ~/exercises/$NEW_WORKSHOP_NAME
    docker build -t $REGISTRY_URL/$REGISTRY_USERNAME/$NEW_WORKSHOP_NAME:latest .
    echo $REGISTRY_PASSWORD | docker login $REGISTRY_URL -u $REGISTRY_USERNAME --password-stdin
    docker push $REGISTRY_URL/$REGISTRY_USERNAME/$NEW_WORKSHOP_NAME:latest
    echo "Docker image $REGISTRY_URL/$REGISTRY_USERNAME/$NEW_WORKSHOP_NAME:latest built and pushed successfully."
