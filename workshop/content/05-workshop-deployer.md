This activity will help you deploy the workshop on a Kubernetes cluster using eduk8s. Follow the steps below to ensure a successful deployment.

## 1. Check the Defined Deployment Configuration

Ensure that your deployment configuration is correctly defined by opening the environment variables file:

```editor:open-file
file: ~/project/set_env_vars.sh
```

## 2. Commit and Push Changes

Make sure all changes in your workshop are committed and pushed to the repository. This ensures that your deployment uses the latest version of your workshop.

```execute-1
sh ~/project/push_changes.sh
```

## 3. Connect to the Desired Kubernetes Cluster

To connect to the desired Kubernetes cluster for deployment, upload the kubeconfig file. To generate kubeconfig for you cluster use -
kubectl config view --minify --context=[name] --raw > kubeconfig 

```files:upload-file
path: kubeconfig
```

## 4. Deploy eduk8s (if not already deployed)
Note: eduk8s must be installed on the cluster. This workshop currently doesn't support eduk8s deployment. Follow the [eduk8s installation instructions](https://docs.educates.dev/installation-guides/installation-instructions/) from the eduk8s documentation.


## 5. Deploy the Workshop on the Cluster
Deploy your workshop on the cluster. This action will also deploy the portal for the workshop.  If not specified, it will use the default portal "educates-cli".

```execute-1
sh ~/project/deploy_workshop.sh
```

## 6. Browse the Deployed Workshop
Once the workshop is deployed, you can browse it using the following command:

```execute-1
educates browse-workshops --kubeconfig=$HOME/uploads/kubeconfig
```

