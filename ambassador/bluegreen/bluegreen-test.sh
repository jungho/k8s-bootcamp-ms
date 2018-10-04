#! /bin/bash

helm install --debug --dry-run  --name todo-green  ../helm-todo-app/ --set ui.image=thefenns/todo-ui --set ui.version=green --set deployment.namespace=green
helm install --debug --dry-run --name todo-blue  ../helm-todo-app/ --set ui.image=thefenns/todo-ui --set ui.version=blue --set deployment.namespace=blue
