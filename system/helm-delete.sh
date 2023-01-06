# delete old helm charts if exists
microk8s helm3 uninstall frontend-app 
microk8s helm3 uninstall backend-app 
microk8s helm3 uninstall db-app 