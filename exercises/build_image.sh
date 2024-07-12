#!/bin/sh


# Create the Docker config.json
DOCKER_CONFIG_JSON=$(jq -n --arg url "https://$REGISTRY_URL/v1/" --arg username "$REGISTRY_USERNAME" --arg password "$REGISTRY_PASSWORD" '{
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
kubectl create secret generic kaniko-secret --from-file=.dockerconfigjson=docker-config.json --type=kubernetes.io/dockerconfigjson

# Create a ConfigMap from the Dockerfile
kubectl delete configmap kaniko-config --ignore-not-found
kubectl create configmap kaniko-config --from-file=Dockerfile=../$WORKSHOP_NAME/Dockerfile

# Replace placeholders in the template and generate the final YAML file
envsubst < kaniko-pod.yaml.template > kaniko-pod.yaml

# Apply the Kaniko Pod
kubectl delete pod kaniko --ignore-not-found
kubectl apply -f kaniko-pod.yaml

# Wait for the Kaniko Pod to complete
# kubectl wait --for=condition=complete pod/kaniko --timeout=600s

# Check the logs to ensure the image was built and pushed successfully
kubectl logs -f kaniko


