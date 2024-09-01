#!/bin/bash

# Source the credentials file
source /root/credentials.sh

# Define repository URL and paths
REPO_URL="https://${GITHUB_USERNAME}:${GITHUB_PAT}@github.com/absaro/docker.git"
REPO_DIR="$HOME/docker-repo"
CONFIG_DIR="$HOME/.mysterium"

# Update and install required packages
sudo apt-get update
sudo apt-get install -y ca-certificates curl git

# Set up Docker's official apt repository
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker's repository to apt sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update apt package list again
sudo apt-get update

# Install Docker Engine and related packages
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add Docker to be used without sudo
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Make Docker auto run at startup
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Pull and run Docker containers for passive income apps

# Honeygain
docker pull honeygain/honeygain
docker run -d \
  --name honeygain_container \
  honeygain/honeygain -tou-accept \
  -email "$HONEYGAIN_EMAIL" \
  -pass "$HONEYGAIN_PASS" \
  -device linux

# Pawns
docker pull iproyal/pawns-cli:latest
docker run -d \
  --name pawns_cli_container \
  --restart=unless-stopped \
  iproyal/pawns-cli:latest \
  -email "$PAWNS_EMAIL" \
  -password="$PAWNS_PASS" \
  -device-name=github \
  -device-id=codepsace \
  -accept-tos

# PacketStream
docker pull packetstream/psclient:latest
docker run -d --restart=always -e CID="$PACKETSTREAM_CID" --name psclient packetstream/psclient:latest
docker run -d --restart=always --name watchtower \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower --cleanup --include-stopped --include-restarting --revive-stopped --interval 60 psclient

# Repocket
docker pull repocket/repocket:latest
docker run --name repocket \
  -e RP_EMAIL="$REPOCKET_EMAIL" \
  -e RP_API_KEY="$REPOCKET_API_KEY" \
  -d --restart=always repocket/repocket:latest

# ProxyRack
docker pull proxyrack/pop:latest
docker run -d --name proxyrack --restart always \
  -e UUID="$PROXYRACK_UUID" proxyrack/pop:latest

# Mysterium Node
if [ ! -d "$REPO_DIR" ]; then
  echo "Repository directory not found. Cloning from repository..."
  git clone "$REPO_URL" "$REPO_DIR"
else
  echo "Repository found. Pulling latest changes..."
  cd "$REPO_DIR"
  git pull
fi

# Fix permissions
sudo chown -R "$(whoami)" "$CONFIG_DIR"

# Ensure the Mysterium configuration directory exists
mkdir -p "$CONFIG_DIR"

# Copy the Mysterium configuration files to the correct directory
cp -r "$REPO_DIR/.mysterium" "$CONFIG_DIR"

# Run the Mysterium Node using Docker with the official command
sudo docker run --cap-add NET_ADMIN --net host --name myst -d mysteriumnetwork/myst service --agreed-terms-and-conditions

# Set up log rotation for Docker containers
cat <<EOF | sudo tee /etc/logrotate.d/docker-containers
/var/lib/docker/containers/*/*.log {
    rotate 7
    daily
    compress
    delaycompress
    missingok
    notifempty
}
EOF

echo "Setup complete!"
