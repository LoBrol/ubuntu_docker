#!/bin/bash


# --- UPDATE and UPGRADE ---
sudo apt update
sudo apt upgrade -y
sudo apt install -y nala nano curl wget git neofetch lm-sensors zsh openssh-server



# --- Allow SSH on FIREWALL ---
sudo ufw allow ssh



# --- Setting up IP ---
sudo rm /etc/netplan/50-cloud-init.yaml
sudo wget https://raw.githubusercontent.com/LoBrol/ubuntu_docker/main/file_to_be_copied/50-cloud-init.yaml -P /etc/netplan/



# --- Setting up NANO ---
sudo rm /etc/nanorc
sudo wget https://raw.githubusercontent.com/LoBrol/ubuntu_docker/main/file_to_be_copied/nanorc -P /etc/



# --- Setting up MOTD ---
sudo rm -rf /etc/legal
sudo chmod -x /etc/update-motd.d/10-help-text
sudo chmod -x /etc/update-motd.d/50-motd-news
sudo wget https://raw.githubusercontent.com/LoBrol/ubuntu_docker/main/file_to_be_copied/20-neofetch -P /etc/update-motd.d/
sudo chmod +x /etc/update-motd.d/20-neofetch



# --- Setting up SENSORS ---
echo "Y Y Y" | sudo sensors-detect



# --- Setting up ZSH ---
echo "N exit" | sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
rm .zshrc
wget https://raw.githubusercontent.com/LoBrol/ubuntu_docker/main/file_to_be_copied/.zshrc
wget https://raw.githubusercontent.com/LoBrol/ubuntu_docker/main/file_to_be_copied/.p10k.zsh
chsh -s /bin/zsh



# --- Install DOCKER ---
sudo apt -y install apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu mantic stable"
apt-cache policy docker-ce
sudo apt install -y docker-ce



# --- Setting up DOCKER ---
sudo usermod -aG docker ${USER}
su - ${USER}
sudo usermod -aG docker ${USER}
