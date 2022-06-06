# run config
kubectl apply -f postgres-config.yaml

# create service
kubectl apply -f postgres-service.yaml

# create storage
kubectl apply -f postgres-storage.yaml

# create deployment
kubectl apply -f postgres-deployment.yaml