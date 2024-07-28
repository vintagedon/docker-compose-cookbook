#!/bin/bash

# GitLab CE Docker Initialization Script

# Check if .env file exists, if not, copy from .env.example
if [ ! -f .env ]; then
    echo "Creating .env file from .env.example"
    cp .env.example .env
    echo "Please edit .env file with your specific configurations"
    exit 1
fi

# Source the .env file
source .env

# Check if required environment variables are set
required_vars=("GITLAB_HOSTNAME" "GITLAB_EXTERNAL_URL" "HTTP_PORT" "HTTPS_PORT" "SSH_PORT")
for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        echo "Error: $var is not set in .env file"
        exit 1
    fi
done

# Create necessary directories
mkdir -p ./gitlab/{config,data,logs}

# Set correct permissions
chown -R 998:998 ./gitlab

# Pull the latest GitLab image
docker-compose pull

# Start GitLab
docker-compose up -d

# Wait for GitLab to be fully up
echo "Waiting for GitLab to start..."
until curl -s http://localhost:${HTTP_PORT}/users/sign_in > /dev/null; do
    echo -n "."
    sleep 5
done
echo "GitLab is up!"

# Print access information
echo "GitLab is now running!"
echo "Access it via: ${GITLAB_EXTERNAL_URL}"
echo "Default username: root"
echo "Set the root password on first login"

# Optionally, you can add more initialization steps here, such as:
# - Creating initial users
# - Setting up initial projects
# - Configuring CI runners

echo "Initialization complete!"