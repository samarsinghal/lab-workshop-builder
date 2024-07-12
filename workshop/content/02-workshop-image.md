---
title: Create workshop custom image and test 
---

This is the first page of the workshop instructions, create as many separate pages as you need to. If necessary pages can be located in sub directories to provided grouping.

Update the docker file with all the requires tools on the workshop.

```execute-1
mv ~/exercises/Dockerfile ~/$WORKSHOP_NAME/Dockerfile
```

```editor:open-file
file: ~/$WORKSHOP_NAME/Dockerfile
```

```execute-1
sh ~/exercises/build_image.sh
```

Test build workshop image for all the required tools and CLI on terminal 2

```execute-2
kubectl run $WORKSHOP_NAME --image=$REGISTRY_URL/$REGISTRY_USERNAME/$WORKSHOP_NAME:$WORKSHOP_VERSION --restart=Never
kubectl get po $WORKSHOP_NAME
kubectl exec -it $WORKSHOP_NAME -- /bin/bash
```