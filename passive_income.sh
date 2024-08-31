#!binbash

# Source the credentials file
source rootcredentials.sh

# Define repository URL and paths
REPO_URL=https$GITHUB_USERNAME$GITHUB_PAT@github.comabsarodocker.git
REPO_DIR=$HOMEdocker-repo
CONFIG_DIR=$HOME.mysterium

# Update and install required packages
sudo apt-get update
sudo apt-get install -y docker.io git

# Add Docker to be used without sudo
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Make Docker auto run at startup
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Pull and run Docker containers for passive income apps
# Honeygain
docker pull honeygainhoneygain
docker run -d 
  --name honeygain_container 
  honeygainhoneygain -tou-accept 
  -email $HONEYGAIN_EMAIL 
  -pass $HONEYGAIN_PASS 
  -device linux

# Pawns
docker pull iproyalpawns-clilatest
docker run -d 
  --name pawns_cli_container 
  --restart=unless-stopped 
  iproyalpawns-clilatest 
  -email $PAWNS_EMAIL 
  -password=$PAWNS_PASS 
  -device-name=github 
  -device-id=codepsace 
  -accept-tos

# PacketStream
docker run -d --restart=always -e CID=$PACKETSTREAM_CID --name psclient packetstreampsclientlatest
docker run -d --restart=always --name watchtower 
  -v varrundocker.sockvarrundocker.sock 
  containrrrwatchtower --cleanup --include-stopped --include-restarting --revive-stopped --interval 60 psclient

# Repocket
docker pull repocketrepocketlatest
docker run --name repocket 
  -e RP_EMAIL=$REPOCKET_EMAIL 
  -e RP_API_KEY=$REPOCKET_API_KEY 
  -d --restart=always repocketrepocket

# ProxyRack
docker pull proxyrackpop
docker run -d --name proxyrack --restart always 
  -e UUID=$PROXYRACK_UUID proxyrackpop

# Mysterium Node
if [ ! -d $REPO_DIR ]; then
  echo Repository directory not found. Cloning from repository...
  git clone $REPO_URL $REPO_DIR
else
  echo Repository found. Pulling latest changes...
  cd $REPO_DIR
  git pull
fi

# Fix permissions
sudo chown -R $(whoami) $CONFIG_DIR

# Ensure the Mysterium configuration directory exists
mkdir -p $CONFIG_DIR

# Copy the Mysterium configuration files to the correct directory
cp -r $REPO_DIR.mysterium $CONFIG_DIR

# Run the Mysterium Node using Docker with the official command
sudo docker run --cap-add NET_ADMIN --net host --name myst -d mysteriumnetworkmyst service --agreed-terms-and-conditions

# Set up log rotation for Docker containers
cat EOF  sudo tee etclogrotate.ddocker-containers
varlibdockercontainers.log {
    rotate 7
    daily
    compress
    delaycompress
    missingok
    notifempty
}
EOF

echo Setup complete!
