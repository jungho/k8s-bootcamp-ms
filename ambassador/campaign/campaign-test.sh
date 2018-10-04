#! /bin/bash

helm install --name todo-campaign-green  ../helm-todo-app/ \
--debug --dry-run \
--set ui.image=thefenns/todo-ui \
--set ui.version=green \
--set deployment.namespace=campaign-green \
--set deployment.enableWeight=false \
--set deployment.weight=50 \
--set deployment.host=green.architech.ca \
--set deployment.enableHost=true

helm install --name todo-campaign-blue  ../helm-todo-app/ \
--debug --dry-run \
--set ui.image=thefenns/todo-ui \
--set ui.version=blue \
--set deployment.namespace=campaign-blue \
--set deployment.enableWeight=false \
--set deployment.weight=50 \
--set deployment.host=blue.architech.ca \
--set deployment.enableHost=true
