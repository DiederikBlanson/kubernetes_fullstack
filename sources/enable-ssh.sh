# enable ssh on ubuntu by downloading openssh
# source: https://linuxhint.com/enable-use-ssh-ubuntu/
sudo apt install openssh-server -y
sudo systemctl status ssh
sudo ufw allow ssh
sudo ufw enable && sudo ufw reload