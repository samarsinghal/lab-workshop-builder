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
kubectl run $NEW_WORKSHOP_NAME --image=$REGISTRY_URL/$REGISTRY_USERNAME/$NEW_WORKSHOP_NAME:$WORKSHOP_VERSION --restart=Never
kubectl get po $NEW_WORKSHOP_NAME
kubectl exec -it $NEW_WORKSHOP_NAME -- /bin/bash
clear
```