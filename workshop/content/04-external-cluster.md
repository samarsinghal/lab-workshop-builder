---
title: Create workshop custom image and test 
---

This is the first page of the workshop instructions, create as many separate pages as you need to. If necessary pages can be located in sub directories to provided grouping.

Update the docker file with all the requires tools on the workshop.

```editor:open-file
file: ~/project/Dockerfile
```

```execute-1
sh ~/project/build_image.sh
```

Test build workshop image for all the required tools and CLI on terminal 2

```execute-2
source ~/project/set_env_vars.sh
kubectl run $WORKSHOP_NAME --image=$REGISTRY_URL/$REGISTRY_USERNAME/$WORKSHOP_NAME:$WORKSHOP_VERSION --restart=Never
kubectl get po $WORKSHOP_NAME
kubectl exec -it $WORKSHOP_NAME -- /bin/bash
clear
```