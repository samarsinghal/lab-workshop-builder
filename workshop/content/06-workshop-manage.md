---
title: Create workshop custom image and test 
---

This is the first page of the workshop instructions, create as many separate pages as you need to. If necessary pages can be located in sub directories to provided grouping.

sh build_image.sh

kubectl run $NEW_WORKSHOP_NAME --image=$REGISTRY_URL/$REGISTRY_USERNAME/$NEW_WORKSHOP_NAME:$WORKSHOP_VERSION --restart=Never

kubectl get po $NEW_WORKSHOP_NAME

kubectl exec -it $NEW_WORKSHOP_NAME -- /bin/bash