#!/bin/bash

# Update package list and install required packages
sudo apt-get update
sudo apt-get install -y wget curl unzip python3 python3-pip git

# Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get -f install -y  # Fix any dependency issues

# Get the installed version of Chrome
CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+\.\d+')

# Install ChromeDriver that matches the installed Chrome version
CHROME_DRIVER_URL="https://storage.googleapis.com/chrome-for-testing-public/$CHROME_VERSION/linux64/chromedriver-linux64.zip"
wget "$CHROME_DRIVER_URL"
unzip chromedriver-linux64.zip
sudo mv chromedriver /usr/local/bin/chromedriver
sudo chmod +x /usr/local/bin/chromedriver

# Install Selenium
pip3 install selenium

# Clone the GitHub repository
sudo git clone https://github.com/absaro/autoCWlin.git /root/autoCWlin

# Move the 'scripts' folder to the root directory
sudo mv /root/autoCWlin/scripts /root/scripts

# Move the 'run_all_scripts.sh' to the root directory
sudo mv /root/autoCWlin/run_all_scripts.sh /root/

# Delete the 'README.md' file
sudo rm /root/autoCWlin/README.md

# Remove the now empty repository directory
sudo rmdir /root/autoCWlin

# Ensure the run_all_scripts.sh is executable
sudo chmod +x /root/run_all_scripts.sh

# Configure cron job to run the wrapper script daily
(crontab -l 2>/dev/null; echo "0 0 * * * /root/run_all_scripts.sh") | crontab -

# Download the passive_income.sh script from GitHub
wget https://github.com/absaro/autoCWlin/raw/main/passive_income.sh -O /root/passive_income.sh

# Make the scripts executable
chmod +x /root/passive_income.sh

# Run the passive_income.sh script
/root/passive_income.sh

echo "Setup complete!"
