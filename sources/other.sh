# username and password is by default: ubuntu ubuntu
# https://www.cyberciti.biz/faq/ubuntu-change-hostname-command/
# https://askubuntu.com/questions/34074/how-do-i-change-my-username


# -------- Change computer name
sudo nano /etc/hostname
# change the value to the desired one



# ---------- show kubernetes dashboard -------

# get token
token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
microk8s kubectl -n kube-system describe secret $token

# enable dashboard
# Run in the node with the control panel the following command with the own emailaddress
# From another computer you can now access the node from https://[ip-control]:10443
microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard --address [own-ip] 10443:443

# for inside the owm machine
microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard --address localhost 10443:443