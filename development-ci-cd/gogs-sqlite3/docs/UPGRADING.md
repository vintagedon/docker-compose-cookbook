# Upgrading Guide for Gogs with SQLite3 Docker Setup

This document provides instructions for upgrading your Gogs instance with SQLite3 backend running in a Docker container.

## Table of Contents

- [Upgrading Guide for Gogs with SQLite3 Docker Setup](#upgrading-guide-for-gogs-with-sqlite3-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Before You Begin](#before-you-begin)
  - [Upgrade Process](#upgrade-process)
  - [Post-Upgrade Steps](#post-upgrade-steps)
  - [Troubleshooting](#troubleshooting)
  - [Downgrading](#downgrading)

## Before You Begin

1. **Backup**: Always create a full backup of your Gogs data before upgrading. This includes:

   - SQLite3 database file
   - Repository data
   - Custom configuration files
   - Any custom files or templates

2. **Check Compatibility**: Review the [Gogs release notes](https://github.com/gogs/gogs/releases) for any breaking changes or special upgrade instructions.

3. **Downtime Planning**: Plan for a maintenance window as the upgrade process will require stopping the Gogs service.

## Upgrade Process

1. **Stop the current Gogs container**:

   ```
   docker-compose down
   ```

2. **Update the Gogs version**:
   Edit your `.env` file and update the `GOGS_VERSION` variable to the desired version.

3. **Pull the new Gogs image**:

   ```
   docker-compose pull
   ```

4. **Start the updated Gogs container**:

   ```
   docker-compose up -d
   ```

5. **Monitor the logs for any errors**:
   ```
   docker-compose logs -f
   ```

## Post-Upgrade Steps

1. **Verify Functionality**:

   - Check that you can log in to the web interface
   - Verify that existing repositories are accessible
   - Test basic functions like creating issues or pull requests

2. **Run Database Migrations**:
   Gogs should automatically run any necessary database migrations. Check the logs to confirm this has happened successfully.

3. **Update Custom Configuration**:
   If you have any custom configurations in `app.ini`, review them against the new default configuration to ensure compatibility and to take advantage of any new features.

4. **Clear Cache**:
   If you're using a caching service like Memcached, consider clearing the cache after the upgrade:

   ```
   docker-compose exec gogs sh -c "/app/gogs/gogs admin flush-cache"
   ```

5. **Update Hooks**:
   If you have any custom Git hooks, review and update them if necessary.

## Troubleshooting

If you encounter issues after upgrading:

1. **Check Logs**: Review the Docker logs for any error messages:

   ```
   docker-compose logs gogs
   ```

2. **Verify File Permissions**: Ensure that file permissions are correct, especially if you've made changes to volume mounts.

3. **Compare Configurations**: If you're having configuration-related issues, compare your `app.ini` with the default configuration for the new version.

4. **Restore from Backup**: If all else fails, you can restore from your backup and try the upgrade process again.

## Downgrading

If you need to downgrade to a previous version:

1. Stop the current container.
2. Update the `GOGS_VERSION` in your `.env` file to the desired older version.
3. Start the container with the older version.
4. Restore your data from a backup taken before the upgrade.

Note: Downgrading may cause issues due to database schema changes. It's always preferable to fix issues with the current version rather than downgrading.

Remember to always refer to the official [Gogs documentation](https://gogs.io/docs) and release notes for the most up-to-date and version-specific upgrade instructions.
