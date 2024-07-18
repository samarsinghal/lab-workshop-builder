
In order to provide a robust and ready-to-use environment for the participants it is important to create a workshop image, begin by updating the Dockerfile with all the necessary tools required for the workshop. This involves specifying the base image and including the additional application binaries or tools needed for the custom workshop environment. This step ensures that the Dockerfile is tailored to meet the specific requirements of the workshop, providing a robust and ready-to-use environment for the participants.

## Steps to create and test workshop image

1. **Check if workshop image file exists; if not create one:**

    ```execute-1
    sh ~/project/create_image.sh
    ```

2. **Choose base image:**

    JDK 8

    ```execute-1
    sed -i "s|^FROM .*|FROM ghcr.io/vmware-tanzu-labs/educates-jdk8-environment:develop |" ~/exercises/$NEW_WORKSHOP_NAME/Dockerfile
    ```

    JDK 11

    ```execute-1
    sed -i "s|^FROM .*|FROM ghcr.io/vmware-tanzu-labs/educates-jdk11-environment:develop |" ~/exercises/$NEW_WORKSHOP_NAME/Dockerfile
    ```

    JDK 17
    
    ```execute-1
    sed -i "s|^FROM .*|FROM ghcr.io/vmware-tanzu-labs/educates-jdk17-environment:develop |" ~/exercises/$NEW_WORKSHOP_NAME/Dockerfile
    ```

    JDK 21
    
    ```execute-1
    sed -i "s|^FROM .*|FROM ghcr.io/vmware-tanzu-labs/educates-jdk21-environment:develop |" ~/exercises/$NEW_WORKSHOP_NAME/Dockerfile
    ```

    Anaconda workshop base image
    
    ```execute-1
    sed -i "s|^FROM .*|FROM ghcr.io/vmware-tanzu-labs/educates-conda-environment:develop |" ~/exercises/$NEW_WORKSHOP_NAME/Dockerfile
    ```

3. **Add capabilities/tools on base image:**

    [TBD]

4. **Open Image file for edit:** Update the docker file with all the requires tools on the workshop.

5. **Build and push the image to image repository:**

    This workshop uses Kaniko to build the image and push it to the defined image registry.

    ```execute-1
    sh ~/project/build_image.sh
    ```

6. **Test build workshop image for all the required tools and CLI on terminal 2:**

    ```execute-2
    kubectl run $NEW_WORKSHOP_NAME --image=$REGISTRY_URL/$REGISTRY_USERNAME/$NEW_WORKSHOP_NAME:$WORKSHOP_VERSION --restart=Never
    kubectl wait --for=condition=Ready pod/$NEW_WORKSHOP_NAME --timeout=300s
    kubectl get po $NEW_WORKSHOP_NAME
    kubectl exec -it $NEW_WORKSHOP_NAME -- /bin/bash
    clear
    ```
    
7. **Exit Image:**

    ```execute-2
    exit
    ```
