#!/bin/bash

# Wireguard Setup Script

# Check if running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Update system
echo "Updating system..."
apt-get update && apt-get upgrade -y

# Install Docker if not already installed
if ! [ -x "$(command -v docker)" ]; then
  echo "Installing Docker..."
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
  usermod -aG docker $USER
fi

# Install Docker Compose if not already installed
if ! [ -x "$(command -v docker-compose)" ]; then
  echo "Installing Docker Compose..."
  curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
fi

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
  echo "Creating .env file..."
  cp .env.example .env
  # Generate random port
  RANDOM_PORT=$(shuf -i 10000-60000 -n 1)
  sed -i "s/SERVER_PORT=51820/SERVER_PORT=$RANDOM_PORT/" .env
  echo "Random port $RANDOM_PORT has been set in .env file."
fi

# Start Wireguard container
echo "Starting Wireguard container..."
docker-compose up -d

# Display info
echo "Wireguard setup complete!"
echo "Please check the 'config' directory for peer configurations."
echo "Remember to open UDP port $(grep SERVER_PORT .env | cut -d '=' -f2) on your firewall."

# Reminder about security
echo "Please review the SECURITY.md file for important security considerations."