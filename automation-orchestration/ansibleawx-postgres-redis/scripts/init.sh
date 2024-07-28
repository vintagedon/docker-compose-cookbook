#!/bin/bash

# Wait for the database to be ready
until PGPASSWORD=$POSTGRES_PASSWORD psql -h "postgres" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command"

# Run AWX migrations
awx-manage migrate --noinput

# Create the admin user
echo "from django.contrib.auth.models import User; User.objects.create_superuser('$AWX_ADMIN_USER', 'admin@example.com', '$AWX_ADMIN_PASSWORD') if not User.objects.filter(username='$AWX_ADMIN_USER').exists() else None" | awx-manage shell

# Load initial data
awx-manage create_preload_data

echo "Initialization complete"