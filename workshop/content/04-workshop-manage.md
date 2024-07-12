---
title: Create workshop custom image and test 
---

This is the first page of the workshop instructions, create as many separate pages as you need to. If necessary pages can be located in sub directories to provided grouping.

sh build_image.sh

kubectl run $WORKSHOP_NAME --image=$REGISTRY_URL/$REGISTRY_USERNAME/$WORKSHOP_NAME:$WORKSHOP_VERSION --restart=Never

kubectl get po $WORKSHOP_NAME

kubectl exec -it $WORKSHOP_NAME -- /bin/bash