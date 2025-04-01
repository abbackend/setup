#!/bin/bash

# Check if a project name is provided
if [ -z "$1" ]; then
    echo "Error: Project name is required!"
    echo "Usage: $0 <project-name>"
    exit 1
fi

# Create a new Laravel project in ~/Herd
cd ~/Herd && laravel new "$1"

# Add subdomain to /etc/hosts
line_to_append="127.0.0.1       $1.test"
echo "$line_to_append" | sudo tee -a /etc/hosts > /dev/null

# Update the APP_URL in the project’s .env file
cd ~/Herd/"$1" && sed -i "s|^APP_URL=.*|APP_URL=http://${1}.test|" .env

# Notify the user
echo "You can access it using: http://$1.test"
