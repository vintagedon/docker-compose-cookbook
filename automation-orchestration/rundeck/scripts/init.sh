#!/bin/bash

# Wait for the database to be ready
until nc -z -v -w30 db 3306
do
  echo "Waiting for database connection..."
  sleep 5
done

# Initialize Rundeck (add your initialization logic here)
echo "Initializing Rundeck..."

# Example: Create a default project
rd-project -a create --project my-project --file /home/rundeck/my-project.properties

# Example: Import a job definition
# rd jobs load -p my-project --file /home/rundeck/my-job.yaml

echo "Rundeck initialization complete."