# run config
kubectl apply -f frontend-config.yaml

# create deployment
kubectl apply -f frontend-deploy.yaml

# check pods related to the deployment
kubectl get pods -l app=frontend

# create service
kubectl apply -f frontend-service.yaml