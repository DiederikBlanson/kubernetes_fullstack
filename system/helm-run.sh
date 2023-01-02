# delete old helm charts if exists
microk8s helm3 uninstall frontend-app 
microk8s helm3 uninstall backend-app 

# create new helm charts
microk8s helm3 install backend-app ./backend/helm-backend
microk8s helm3 install frontend-app ./frontend/helm-frontend