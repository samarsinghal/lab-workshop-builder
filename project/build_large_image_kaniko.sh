#!/bin/sh

# cp -u ~/project/Dockerfile ~/exercises/$NEW_WORKSHOP_NAME/Dockerfile

# Create the Docker config.json
DOCKER_CONFIG_JSON=$(jq -n --arg url "https://index.$REGISTRY_URL/v1/" --arg username "$REGISTRY_USERNAME" --arg password "$REGISTRY_PASSWORD" '{
  "auths": {
    ($url): {
      "username": $username,
      "password": $password,
      "auth": ($username + ":" + $password | @base64)
    }
  }
}')

echo "$DOCKER_CONFIG_JSON" > docker-config.json

# Create the Kubernetes Secret
kubectl delete secret kaniko-secret --ignore-not-found
kubectl create secret generic kaniko-secret --from-literal=.dockerconfigjson="$DOCKER_CONFIG_JSON" --type=kubernetes.io/dockerconfigjson

# Create a ConfigMap from the Dockerfile
kubectl delete configmap kaniko-config --ignore-not-found
kubectl create configmap kaniko-config --from-file=Dockerfile=/home/eduk8s/exercises/$NEW_WORKSHOP_NAME/Dockerfile

# Replace placeholders in the template and generate the final YAML file
envsubst < ~/project/kaniko_pod.yaml.template > ~/project/kaniko_pod.yaml

# Apply the Kaniko Pod
kubectl delete pod kaniko --ignore-not-found
kubectl apply -f ~/project/kaniko_pod.yaml

# kubectl logs kaniko -f

Wait for the Kaniko Pod to complete
kubectl wait --for=condition=complete pod/kaniko --timeout=300s

Check the logs to ensure the image was built and pushed successfully
kubectl logs -f kaniko


