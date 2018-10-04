#! /bin/bash

helm install --name todo-green  ../helm-todo-app/ --set ui.image=thefenns/todo-ui --set ui.version=green --set deployment.namespace=green --set deployment.enableHeader=true
helm install --name todo-blue  ../helm-todo-app/ --set ui.image=thefenns/todo-ui --set ui.version=blue --set deployment.namespace=blue --set deployment.enableHeader=true
