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

# add to ~/.bash_aliases -> alias kubectl='microk8s kubectl'

# add microk8s modules
microk8s enable dns storage
microk8s enable registry
microk8s enable helm3
microk8s enable dashboard
microk8s start

# now the required modules are installed, the following are nice-to-have
sudo snap install curl