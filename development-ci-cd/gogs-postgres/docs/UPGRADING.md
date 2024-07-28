# Upgrading Guide for Gogs with PostgreSQL

This document provides instructions on how to upgrade your Gogs instance with PostgreSQL in a Docker environment.

## Table of Contents

- [Upgrading Guide for Gogs with PostgreSQL](#upgrading-guide-for-gogs-with-postgresql)
  - [Table of Contents](#table-of-contents)
  - [Before You Begin](#before-you-begin)
  - [Upgrading Gogs](#upgrading-gogs)
  - [Upgrading PostgreSQL](#upgrading-postgresql)
  - [Post-Upgrade Steps](#post-upgrade-steps)
  - [Troubleshooting](#troubleshooting)

## Before You Begin

1. **Backup Your Data**: Always create a full backup of your Gogs data and PostgreSQL database before upgrading.

   ```bash
   # Backup Gogs data
   docker run --rm --volumes-from gogs -v $(pwd):/backup alpine tar czvf /backup/gogs-data-backup.tar.gz /data

   # Backup PostgreSQL database
   docker exec gogs-postgres pg_dump -U gogs gogs > gogs-db-backup.sql
   ```

2. **Check Compatibility**: Review the [Gogs release notes](https://github.com/gogs/gogs/releases) for any breaking changes or special upgrade instructions.

3. **Plan for Downtime**: Schedule the upgrade during a maintenance window to minimize disruption.

## Upgrading Gogs

1. Update the Gogs image version in your `docker-compose.yml` file:

   ```yaml
   services:
     gogs:
       image: gogs/gogs:latest # Replace 'latest' with the specific version if desired
   ```

2. Pull the new Gogs image:

   ```bash
   docker-compose pull gogs
   ```

3. Stop and remove the existing Gogs container:

   ```bash
   docker-compose stop gogs
   docker-compose rm gogs
   ```

4. Start the new Gogs container:

   ```bash
   docker-compose up -d gogs
   ```

5. Check the logs for any errors:

   ```bash
   docker-compose logs gogs
   ```

## Upgrading PostgreSQL

Upgrading PostgreSQL requires more caution due to potential data format changes between major versions.

1. Update the PostgreSQL image version in your `docker-compose.yml` file:

   ```yaml
   services:
     postgres:
       image: postgres:13 # Replace with your target version
   ```

2. Stop all services:

   ```bash
   docker-compose down
   ```

3. Rename the old PostgreSQL data volume:

   ```bash
   docker volume create --name postgres_data_new
   docker run --rm -v postgres_data:/from -v postgres_data_new:/to alpine ash -c "cd /from ; cp -av . /to"
   ```

4. Update your `docker-compose.yml` to use the new volume:

   ```yaml
   services:
     postgres:
       volumes:
         - postgres_data_new:/var/lib/postgresql/data
   ```

5. Start the services:

   ```bash
   docker-compose up -d
   ```

6. Run PostgreSQL upgrade commands if necessary (this varies by version):

   ```bash
   docker exec -it gogs-postgres pg_upgrade
   ```

## Post-Upgrade Steps

1. Verify that Gogs is functioning correctly:

   - Check the web interface
   - Try logging in
   - Perform a test Git operation

2. Run any necessary database migrations:

   ```bash
   docker exec -it gogs ./gogs admin run_migrations
   ```

3. Update your backup scripts to reflect any changes in container names or volumes.

4. If everything is working correctly, you can remove the old PostgreSQL data volume:

   ```bash
   docker volume rm postgres_data
   ```

## Troubleshooting

If you encounter issues during or after the upgrade:

1. Check the logs for both Gogs and PostgreSQL:

   ```bash
   docker-compose logs gogs
   docker-compose logs postgres
   ```

2. Verify that all environment variables are correctly set in your `docker-compose.yml` and `.env` files.

3. Ensure that the database connection details in Gogs configuration match your PostgreSQL setup.

4. If necessary, restore from your backup:

   ```bash
   # Restore Gogs data
   docker run --rm --volumes-from gogs -v $(pwd):/backup alpine sh -c "cd /data && tar xzvf /backup/gogs-data-backup.tar.gz --strip 1"

   # Restore PostgreSQL database
   cat gogs-db-backup.sql | docker exec -i gogs-postgres psql -U gogs
   ```

5. If problems persist, consider rolling back to the previous version and seeking help from the Gogs community or support channels.

Remember to always test the upgrade process in a non-production environment first. Regular backups and a well-documented upgrade process are key to successful maintenance of your Gogs instance.
