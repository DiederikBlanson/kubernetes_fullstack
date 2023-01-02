# https://ubuntu.com/tutorials/getting-started-with-kubernetes-ha#4-create-a-microk8s-multinode-cluster

# add worker and master to /etc/hosts for all nodes

# see on which node: kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=<node>