---
title: Set required environment variables for the workshop 
---




```editor:open-file
file: ~/exercises/set_env_vars.sh
```

```execute-1
source ~/exercises/set_env_vars.sh
```

- Create workshop

```execute-1
educates new-workshop $WORKSHOP_NAME --template hugo --image $REGISTRY_URL/$REGISTRY_USERNAME/$WORKSHOP_NAME:$WORKSHOP_VERSION
sh ~/exercises/push-workshop.sh
```

or 

- Upload workshop 
Git clone 

- Sync env variables 



Explore workshop in editor all the files
