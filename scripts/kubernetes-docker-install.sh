# install docker
sudo snap install docker

# install microk8s
sudo snap install microk8s --classic

# verify installation
sudo microk8s kubectl version

# add correct users to namespace
sudo usermod -a -G microk8s $USER 
sudo chown -f -R $USER ~/.kube
su - $USER

# check for microk8s user
groups

# start and test status microk8s
microk8s start
microk8s status --wait-ready

# create ~/.bash_aliases file and append shortcuts
touch ~/.bash_aliases
echo "alias kubectl='microk8s kubectl'" >> ~/.bash_aliases
echo "alias helm3='microk8s helm3'" >> ~/.bash_aliases
echo "alias k='microk8s kubectl'" >> ~/.bash_aliases
source ~/.bash_aliases

# add microk8s modules
microk8s enable dns storage registry ingress helm3 dashboard
microk8s start

# Add hosts. This includes for communication between nodes and DNS resolving.
# Check hosts.txt

# For grub, you might have to disable the boot menu (https://askubuntu.com/questions/111085/how-do-i-hide-the-grub-menu-showing-up-at-the-beginning-of-boot)

# Turn off Swap (https://ubuntu.com/tutorials/getting-started-with-kubernetes-ha#4-create-a-microk8s-multinode-cluster)
sudo swapoff -a
sudo sed -i '/^[^#]*swap.img[[:space:]]*/ s/^/#/' /etc/fstab

# now the required modules are installed, the following are nice-to-have
sudo snap install curl

