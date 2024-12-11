#!/bin/bash

# Official source: https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/

# Establish variables
USER="<user>"
SERVER_IP="<local-ip-server>"

# Establish SSH tunnel
echo "Establishing SSH tunnel to forward port 8443..."
ssh -L localhost:8443:127.0.0.1:8443 "$USER@$SERVER_IP"

# Add Kubernetes Dashboard Helm chart repository
echo "Adding Kubernetes Dashboard Helm chart repository..."
helm3 repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/

# Deploy the Kubernetes Dashboard
echo "Deploying Kubernetes Dashboard with Helm..."
helm3 upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard \
  --create-namespace --namespace kubernetes-dashboard

# Create an admin token
echo "Generating admin-user token for Kubernetes Dashboard..."
TOKEN=$(kubectl -n kubernetes-dashboard create token admin-user)

# Display the token
echo "Use the following token to log in to the dashboard:"
echo "$TOKEN"

# Port forward the Kubernetes Dashboard service
echo "Forwarding Kubernetes Dashboard service to port 8443..."
kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443

# Clean up on exit
cleanup() {
  echo "Cleaning up..."
  kill $SSH_PID $PORT_FORWARD_PID
  echo "Done!"
}
trap cleanup EXIT

# Instructions for accessing the dashboard
echo "The Kubernetes Dashboard is now accessible at https://localhost:8443"
echo "Use the generated token to authenticate."
echo "Press Ctrl+C to exit and clean up."
wait
