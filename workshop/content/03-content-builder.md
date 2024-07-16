# Create workshop content 

This guide will assist you in defining your own set of workshop instructions. For detailed guidance, refer to the eduk8s documentation, which lists all the possible options you can include in your content. As part of this workshop content creation exercise, we will focus on one content file at a time. You can easily navigate back and forth on content creater to create, update, re-arrange, and test content as needed.

## Create new content
Create new content process will create a new workshop content file with the next available order number, ensuring it fits sequentially with existing files. It prompts the user for a content name and title, then create and displays the content directory's file list.

```execute-1
sh ~/project/create_new_content.sh
```

## Re-arrange content 
This action will help you arrange the workshop content.

```execute-1
sh ~/project/rearrange_content.sh
```

## Test content
This action will load the desired content as next chapter

```execute
sh ~/project/deploy_content.sh
```

## Content Refresh 
This action will refresh the test content

```execute-1
sh ~/project/refresh_content.sh
```

## Configure the terminals to use the new workshop image.
This action will run the workshop image on both terminal instance

```execute-all
kubectl run $NEW_WORKSHOP_NAME --image=$REGISTRY_URL/$REGISTRY_USERNAME/$NEW_WORKSHOP_NAME:$WORKSHOP_VERSION --restart=Never
kubectl wait --for=condition=Ready pod/$NEW_WORKSHOP_NAME --timeout=300s
kubectl get po $NEW_WORKSHOP_NAME
kubectl exec -it $NEW_WORKSHOP_NAME -- /bin/bash
clear
```