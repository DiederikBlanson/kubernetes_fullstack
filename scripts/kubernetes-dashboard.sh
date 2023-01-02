# sources: https://docs.aws.amazon.com/eks/latest/userguide/dashboard-tutorial.html

# get token to access the Kubernetes dashboard
token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
microk8s kubectl -n kube-system describe secret $token

# Run in control plane node the following command with the own-ip address
microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard --address [own-ip] 10443:443

# From another computer you can now access the Kubernetes dashboard from https://[ip-control]:10443

# If you only want it to work within the node, just use 'localhost' instead of the ip address
microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard --address localhost 10443:443