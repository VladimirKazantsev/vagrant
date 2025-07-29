#!/bin/bash
sudo apt-get update
sudo apt-get install -y net-tools
sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo usermod -aG docker $USER
docker volume create portainer_data
docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

sudo cp -r /tmp/vault_jenkins/ /root/
cd /root/vault_jenkins/
#sed -i 's/\r//' init_vault.sh
chmod +x init_vault.sh
sudo docker compose up -d
sleep 15
sudo docker exec vault sh -c ls
sudo docker exec vault sh -c "/init_vault.sh"
sudo docker exec jenkins bash -c "echo 'Пароль от Дженкинс:'; cat /var/jenkins_home/secrets/initialAdminPassword"