#!/bin/bash

# Update package list
sudo apt update -y

# Ensure all dependencies are met
sudo apt install -f -y

# Install required packages
sudo apt install wget unzip apache2 -y

# Enable and start Apache
sudo systemctl enable apache2
sudo systemctl start apache2

# Download and deploy web template
sudo wget -O infinite_loop.zip https://www.tooplate.com/zip-templates/2117_infinite_loop.zip
sudo unzip -o infinite_loop.zip -d infinite_loop
sudo cp -r infinite_loop/* /var/www/html/
sudo systemctl restart apache2
