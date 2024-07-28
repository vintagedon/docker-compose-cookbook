#!/bin/bash

# This script runs when the Gogs container starts

# Wait for Gogs to start
until $(curl --output /dev/null --silent --head --fail http://localhost:3000); do
    printf '.'
    sleep 5
done

# Check if Gogs is already initialized
if [ ! -f /data/gogs/conf/app.ini ]; then
    echo "Initializing Gogs..."
    
    # Create initial admin user
    su git -c "gitea admin create-user --username $ADMIN_USERNAME --password $ADMIN_PASSWORD --email $ADMIN_EMAIL --admin"
    
    # Additional initialization steps can be added here
    
    echo "Gogs initialization complete."
else
    echo "Gogs is already initialized."
fi

# Run any custom scripts or commands here

echo "Initialization script completed."