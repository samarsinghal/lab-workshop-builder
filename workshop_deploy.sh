#!/bin/bash

make build

docker push samarsinghal/lab-workshop-builder:latest

kubectl delete workshops,trainingportals,workshoprequests,workshopsessions,workshopenvironments --all --cascade=foreground

educates publish-workshop --image-repository=docker.io/samarsinghal --registry-username=samarsinghal --registry-password=Docker@12345

educates deploy-workshop --overtime=30m  --overdue=20m --reserved=1 --initial=1

educates browse-workshops
