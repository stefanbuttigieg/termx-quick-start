# Step 1
Install the Docker and "docker compose" in the new Ubuntu 24+ server.
First, ensure that Docker is installed. If it's not, you can install Docker using the official Docker repository. Here are the commands to install Docker:
---
<<<
1. Update Operating System: Update your Ubuntu 24.04
sudo apt update && sudo apt upgrade

2. Install Required Packages
sudo apt install apt-transport-https curl

3. Add Docker’s Official GPG Key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

4. Set Up Docker’s Stable Repository: Add the official Docker repository to your Ubuntu 24.04 LTS system

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

5. Update the APT package index
sudo apt-get update

6. Install the latest version of Docker Engine and containerd
sudo apt-get install docker-ce docker-ce-cli containerd.io

7. Verify Docker Installation
sudo docker run hello-world


# Step 2. Add user with id 1000
1. Similarly to group, you need to check if the user ID (UID) 1000 is already taken:

getent passwd 1000

2. If the UID 1000 is available, you can create a new user with this UID and assign the user to the group with GID 1000.
<<<
sudo useradd -u 1000 -g docker -m -s /bin/bash snowstorm
>>>

3.  To use Docker as a non-root user (which is recommended to prevent the Docker daemon from having too many privileges), you can add your user to the Docker group:
<<<
sudo usermod -aG docker snowstorm
sudo usermod -aG docker root
sudo newgrp docker
>>>

3. Add permissions to the directory will be mapped as external volume of Elasticsearch.
<<<
mkdir -p /root/data
chown -R 1000:1000 /root/data
>>>


# Step 3. Install Ngnix
1. Install Nginx using APT:
sudo apt install nginx

2. Verify the installation
systemctl status nginx

3. Start Ngnix
sudo systemctl start nginx
#sudo systemctl stop nginx

4. To enable the web server:
sudo systemctl enable nginx
#sudo systemctl disable nginx

# Step 4. Add HTTP conf
1. Add XXX conf file
vi /etc/nginx/conf.d/public.conf

2. Restart Nginx server
sudo systemctl restart nginx

# Step 5. Setup HTTPS 
To install HTTPS proceed with Letsencrypt instructions: https://certbot.eff.org/instructions or use instructions below.
NB! In the case of Hetzner install the "Certbot DNS plugin for Hetzner" described in the steps 4-6.

1. Install Certbot using Snap:

sudo snap install --classic certbot

2. Prepare the Certbot command. Create a symbolic link from /snap/bin/certbot to /usr/bin/certbot using the following command:

sudo ln -s /snap/bin/certbot /usr/bin/certbot

3. Check the installed version of Certbot

certbot --version

4. Install the Certbot DNS plugin for Hetzner. This plugin is necessary if you’re using DNS validation with Hetzner

sudo snap install certbot-dns-hetzner

5. Set trust for the plugin.

sudo snap set certbot trust-plugin-with-root=ok

6. Verify the plugin installation

certbot plugins

7. Setup HTTPS. Run this command to get a certificate and have Certbot edit your nginx configuration automatically to serve it, turning on HTTPS access in a single step.

sudo certbot --nginx


# Step 6. Create Docker containers
1. Download docker-compose.yml https://github.com/termx-health/termx-quick-start/blob/main/snomed/docker-compose.yml into /root.

2. Fix directories and ports in the docker-compose.yml if needed.

3. Create containers
docker compose up -d

4. Wait for minute and check Snowstorm logs 
docker logs -f snowstorm



-----------
# Troubleshooting:
1) use "docker compose up -d" instead of "docker-compose up -d"

2) if Elasticserach don't startup after previously working
sudo rm /home/snowstorm/data/dir/nodes/0/node.lock

3) If something very wrong uninstall all images and repeat step 6:
>>>
docker-compose down  # Stop container on current dir if there is a docker-compose.yml
docker rm -fv $(docker ps -aq)  # Remove all containers
sudo lsof -i -P -n | grep 9200  # List who's using the port
sudo lsof -i -P -n | grep 8080  # List who's using the port
sudo lsof -i -P -n | grep 9000  # List who's using the port
kill -9 <pid>   #kill the processes from previous lsof commands

docker rmi <imagename>  # remove installed images
shutdown -r now  # restart server, wait for a minute, check usage of ports (lsof) and then repeat Step 6
<<<
