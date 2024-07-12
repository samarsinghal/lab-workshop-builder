---
title: Create workshop custom image and test 
---

This is the first page of the workshop instructions, create as many separate pages as you need to. If necessary pages can be located in sub directories to provided grouping.


educates publish-workshop --image-repository=docker.io/samarsinghal --registry-username=samarsinghal --registry-password=Docker@12345


educates deploy-workshop --overtime=30m  --overdue=20m --reserved=1 --initial=1


educates browse-workshops
