# Upgrading Guide for Gitea-SQLite3 Docker Setup

This document outlines the steps to upgrade your Gitea instance with SQLite3 backend.

## Table of Contents

- [Upgrading Guide for Gitea-SQLite3 Docker Setup](#upgrading-guide-for-gitea-sqlite3-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Before You Begin](#before-you-begin)
  - [Upgrade Process](#upgrade-process)
  - [Post-Upgrade Steps](#post-upgrade-steps)
  - [Troubleshooting](#troubleshooting)
  - [Downgrading](#downgrading)

## Before You Begin

1. **Backup Your Data**: Always create a full backup before upgrading.

   ```bash
   docker-compose stop
   docker run --rm -v gitea_data:/data -v /path/to/backup:/backup alpine tar cvzf /backup/gitea_data.tar.gz /data
   docker run --rm -v gitea_config:/etc/gitea -v /path/to/backup:/backup alpine tar cvzf /backup/gitea_config.tar.gz /etc/gitea
   docker-compose start
   ```

2. **Check Release Notes**: Review the [Gitea release notes](https://github.com/go-gitea/gitea/releases) for any breaking changes or special upgrade instructions.

3. **Check System Requirements**: Ensure your system meets the requirements for the new version.

## Upgrade Process

1. **Update Gitea Version**: Modify the `GITEA_VERSION` in your `.env` file to the desired version.

2. **Pull New Image**: Pull the new Gitea image.

   ```bash
   docker-compose pull
   ```

3. **Stop Current Container**: Stop the running Gitea container.

   ```bash
   docker-compose down
   ```

4. **Start New Container**: Start Gitea with the new image.

   ```bash
   docker-compose up -d
   ```

5. **Run Migrations**: Gitea will automatically run any necessary database migrations on startup.

## Post-Upgrade Steps

1. **Verify Functionality**: Check that Gitea is running correctly and all features are working as expected.

2. **Check Logs**: Review the Docker logs for any errors or warnings.

   ```bash
   docker-compose logs gitea
   ```

3. **Update Configurations**: If there are any new configuration options, update your `app.ini` file accordingly.

4. **Clean Up**: Remove old Docker images to free up space.

   ```bash
   docker image prune
   ```

## Troubleshooting

If you encounter issues after upgrading:

1. Check the Gitea logs for error messages.
2. Verify that all volumes are correctly mounted.
3. Ensure that the SQLite3 database file has the correct permissions.
4. If necessary, restore from your backup and try the upgrade again.

## Downgrading

If you need to downgrade:

1. Stop the current container.
2. Restore your data from the backup created before upgrading.
3. Update the `GITEA_VERSION` in your `.env` file to the previous version.
4. Start the container with the older image.

Note: Downgrading may not always be possible due to database schema changes. Always refer to the Gitea documentation for version-specific downgrade instructions.
