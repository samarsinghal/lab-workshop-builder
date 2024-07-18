#!/bin/bash

# source ~/project/deploy_content.sh

cp -ur ~/exercises/$NEW_WORKSHOP_NAME/workshop/content /opt/workshop/content/
rm /opt/workshop/content/04-content-tester.md
cp ~/exercises/$NEW_WORKSHOP_NAME/workshop/content/$selected_file /opt/workshop/content/04-content-tester.md

# rm /opt/workshop/content/labs/testcase.md
# rm /opt/workshop/content/labs/testcase.md.in
# rm /opt/workshop/content/labs/setup.md

# cp -u ~/exercises/$NEW_WORKSHOP_NAME/workshop/content/$selected_file /opt/workshop/content/labs/testcase.md.in
# cp -u ~/exercises/$NEW_WORKSHOP_NAME/workshop/content/$selected_file /opt/workshop/content/labs/setup.md
# cp -u ~/exercises/$NEW_WORKSHOP_NAME/workshop/content/$selected_file /opt/workshop/content/labs/testcase.md





# sh deploy.sh scenarios/devops/sc02-tc01.md


# cp -ur scenarios /opt/workshop/content/
# rm /opt/workshop/content/labs/testcase.md
# rm /opt/workshop/content/labs/testcase.md.in
# rm /opt/workshop/content/labs/setup.md

# testcasename=$(basename "$1")
# cp -u $1 /opt/workshop/content/labs/testcase.md.in
# cp -u scenarios/env/$testcasename /opt/workshop/content/labs/setup.md
# cp -u $1 /opt/workshop/content/labs/testcase.md