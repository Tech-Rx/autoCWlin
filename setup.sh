#!/bin/bash

# Update package list and install required packages
sudo apt-get update
sudo apt-get install -y wget curl unzip python3 python3-pip

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

# Download the repository as a ZIP file
wget https://github.com/absaro/autoCWlin/archive/refs/heads/main.zip -O /root/autoCWlin.zip

# Unzip the downloaded file
unzip /root/autoCWlin.zip -d /root

# Move the 'scripts' folder to the root directory
sudo mv /root/autoCWlin-main/scripts /root/scripts

# Move the 'run_all_scripts.sh' to the root directory
sudo mv /root/autoCWlin-main/run_all_scripts.sh /root/

# Delete the 'README.md' file
sudo rm /root/autoCWlin-main/README.md

# Remove the now empty directory
sudo rm -rf /root/autoCWlin-main

# Ensure the run_all_scripts.sh is executable
sudo chmod +x /root/run_all_scripts.sh

# Configure cron job to run the wrapper script daily
(crontab -l 2>/dev/null; echo "0 0 * * * /root/run_all_scripts.sh") | crontab -

echo "Setup complete!"
