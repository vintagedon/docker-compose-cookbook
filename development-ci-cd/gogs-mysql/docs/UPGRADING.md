# Upgrading Guide for Gogs with MySQL Docker Setup

This document outlines the process for upgrading your Gogs instance with MySQL running in Docker.

## Table of Contents

- [Upgrading Guide for Gogs with MySQL Docker Setup](#upgrading-guide-for-gogs-with-mysql-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Before You Begin](#before-you-begin)
  - [Backing Up Your Data](#backing-up-your-data)
  - [Upgrading Gogs](#upgrading-gogs)
  - [Upgrading MySQL](#upgrading-mysql)
  - [Post-Upgrade Steps](#post-upgrade-steps)
  - [Troubleshooting Upgrade Issues](#troubleshooting-upgrade-issues)

## Before You Begin

- Read the release notes for the new Gogs version
- Check compatibility between Gogs, MySQL, and your current setup
- Plan for downtime during the upgrade process
- Inform users about the scheduled maintenance

## Backing Up Your Data

1. Back up Gogs data:

   ```
   docker-compose exec gogs tar -czvf /tmp/gogs-backup.tar.gz /data
   docker cp $(docker-compose ps -q gogs):/tmp/gogs-backup.tar.gz .
   ```

2. Back up MySQL database:
   ```
   docker-compose exec mysql sh -c 'exec mysqldump --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD"' > mysql-backup.sql
   ```

## Upgrading Gogs

1. Update the Gogs version in your `docker-compose.yml`:

   ```yaml
   gogs:
     image: gogs/gogs:NEW_VERSION
   ```

2. Pull the new image:

   ```
   docker-compose pull gogs
   ```

3. Stop and remove the old container:

   ```
   docker-compose stop gogs
   docker-compose rm gogs
   ```

4. Start the new container:

   ```
   docker-compose up -d gogs
   ```

5. Check logs for any errors:
   ```
   docker-compose logs gogs
   ```

## Upgrading MySQL

1. Update the MySQL version in your `docker-compose.yml`:

   ```yaml
   mysql:
     image: mysql:NEW_VERSION
   ```

2. Pull the new image:

   ```
   docker-compose pull mysql
   ```

3. Stop and remove the old container:

   ```
   docker-compose stop mysql
   docker-compose rm mysql
   ```

4. Start the new container:

   ```
   docker-compose up -d mysql
   ```

5. Check logs for any errors:
   ```
   docker-compose logs mysql
   ```

## Post-Upgrade Steps

1. Verify Gogs is running correctly:

   - Check the web interface
   - Test basic operations (login, create repo, push/pull)

2. Run any necessary database migrations:

   - Gogs usually handles this automatically on startup
   - Check Gogs logs for migration status

3. Update your documentation with the new versions

4. Inform users that the upgrade is complete

## Troubleshooting Upgrade Issues

1. If Gogs fails to start after upgrade:

   - Check logs for specific errors
   - Verify database connection settings
   - Ensure all required environment variables are set

2. If database migrations fail:

   - Check Gogs logs for specific migration errors
   - Manually run migrations if necessary (refer to Gogs documentation)

3. If you encounter data inconsistencies:

   - Restore from your backups
   - Reach out to the Gogs community for assistance

4. For version-specific issues:
   - Check the Gogs GitHub issues for known problems
   - Consider rolling back to the previous version if critical issues are found

Remember to always test the upgrade process in a non-production environment first. If you encounter any issues that you can't resolve, don't hesitate to seek help from the Gogs community or consider professional support.
