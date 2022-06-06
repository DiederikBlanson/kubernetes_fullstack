# run config
kubectl apply -f api-config.yaml

# create deployment
kubectl apply -f api-deployment.yaml

# create service
kubectl apply -f api-service.yaml

