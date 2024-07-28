# Upgrading Gitea with PostgreSQL Docker Setup

This document provides instructions for upgrading your Gitea instance with PostgreSQL using Docker.

## Table of Contents

- [Upgrading Gitea with PostgreSQL Docker Setup](#upgrading-gitea-with-postgresql-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Before You Begin](#before-you-begin)
  - [Backup](#backup)
  - [Upgrading Gitea](#upgrading-gitea)
  - [Upgrading PostgreSQL](#upgrading-postgresql)
  - [Post-Upgrade Steps](#post-upgrade-steps)
  - [Troubleshooting](#troubleshooting)

## Before You Begin

1. Read the [Gitea release notes](https://github.com/go-gitea/gitea/releases) for any breaking changes or special upgrade instructions.
2. Check the [PostgreSQL release notes](https://www.postgresql.org/docs/release/) if you're also upgrading PostgreSQL.
3. Ensure you have sufficient disk space for the upgrade process.

## Backup

Before upgrading, it's crucial to create a backup of your data:

1. Back up the Gitea data volume:

   ```
   docker run --rm -v gitea_data:/data -v /path/on/host:/backup alpine tar cvf /backup/gitea_data.tar /data
   ```

2. Back up the PostgreSQL database:
   ```
   docker exec -t gitea-postgres pg_dumpall -c -U gitea > /path/on/host/dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql
   ```

## Upgrading Gitea

1. Update the Gitea image version in your `docker-compose.yml` file:

   ```yaml
   services:
     gitea:
       image: gitea/gitea:latest # Change 'latest' to the desired version
   ```

2. Pull the new Gitea image:

   ```
   docker-compose pull gitea
   ```

3. Stop and remove the existing Gitea container:

   ```
   docker-compose stop gitea
   docker-compose rm gitea
   ```

4. Start the new Gitea container:

   ```
   docker-compose up -d gitea
   ```

5. Check the logs for any errors:
   ```
   docker-compose logs gitea
   ```

## Upgrading PostgreSQL

Upgrading PostgreSQL requires more care, especially for major version upgrades:

1. Update the PostgreSQL image version in your `docker-compose.yml` file:

   ```yaml
   services:
     postgres:
       image: postgres:13 # Change to the desired version
   ```

2. Stop all containers:

   ```
   docker-compose down
   ```

3. Rename the old PostgreSQL data volume:

   ```
   docker volume rename gitea_postgres_data gitea_postgres_data_old
   ```

4. Start the new PostgreSQL container:

   ```
   docker-compose up -d postgres
   ```

5. Copy data from the old volume to the new one:

   ```
   docker run --rm -v gitea_postgres_data_old:/old -v gitea_postgres_data:/new alpine cp -av /old/. /new
   ```

6. Start all containers:
   ```
   docker-compose up -d
   ```

## Post-Upgrade Steps

1. Verify that Gitea is functioning correctly by accessing the web interface.
2. Check that all repositories and data are intact.
3. Run any necessary database migrations:

   ```
   docker-compose exec gitea gitea migrate
   ```

4. If everything is working correctly, you can remove the old PostgreSQL data volume:
   ```
   docker volume rm gitea_postgres_data_old
   ```

## Troubleshooting

If you encounter issues after upgrading:

1. Check the Gitea logs:

   ```
   docker-compose logs gitea
   ```

2. Verify the PostgreSQL logs:

   ```
   docker-compose logs postgres
   ```

3. If necessary, restore from your backup:

   - For Gitea data:
     ```
     docker run --rm -v gitea_data:/data -v /path/on/host:/backup alpine sh -c "rm -rf /data/* /data/..?* /data/.[!.]* ; tar xvf /backup/gitea_data.tar"
     ```
   - For PostgreSQL data:
     ```
     cat /path/on/host/your_dump.sql | docker exec -i gitea-postgres psql -U gitea
     ```

4. If problems persist, consult the [Gitea forum](https://discourse.gitea.io/) or [issue tracker](https://github.com/go-gitea/gitea/issues) for further assistance.

Remember to always test the upgrade process in a non-production environment before applying it to your live system.
