#!/bin/bash

# Initialize Gitea configuration

set -e

# Wait for Gitea to be ready
until curl -s http://localhost:3000 > /dev/null; do
    echo "Waiting for Gitea to be ready..."
    sleep 5
done

# Create admin user if it doesn't exist
if ! gitea admin user list | grep -q "${GITEA_ADMIN_USERNAME}"; then
    gitea admin user create --admin \
        --username "${GITEA_ADMIN_USERNAME}" \
        --password "${GITEA_ADMIN_PASSWORD}" \
        --email "${GITEA_ADMIN_EMAIL}" \
        --must-change-password=false
    echo "Admin user created successfully"
else
    echo "Admin user already exists"
fi

# Create initial organization if specified
if [ -n "${GITEA_INIT_ORG}" ]; then
    if ! gitea admin org list | grep -q "${GITEA_INIT_ORG}"; then
        gitea admin org create \
            --name "${GITEA_INIT_ORG}" \
            --owner "${GITEA_ADMIN_USERNAME}"
        echo "Initial organization created successfully"
    else
        echo "Initial organization already exists"
    fi
fi

# Apply custom configuration
if [ -f /data/gitea/conf/app.ini.custom ]; then
    cp /data/gitea/conf/app.ini.custom /data/gitea/conf/app.ini
    echo "Custom configuration applied"
fi

echo "Gitea initialization complete"