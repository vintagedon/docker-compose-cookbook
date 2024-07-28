# Upgrading SQLite3 Docker Setup

This document provides instructions on how to upgrade your SQLite3 Docker setup to newer versions.

## Table of Contents

- [Upgrading SQLite3 Docker Setup](#upgrading-sqlite3-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Checking Current Version](#checking-current-version)
  - [Upgrading SQLite3](#upgrading-sqlite3)
  - [Backing Up Your Data](#backing-up-your-data)
  - [Upgrading the Docker Image](#upgrading-the-docker-image)
  - [Post-Upgrade Steps](#post-upgrade-steps)
  - [Troubleshooting Upgrade Issues](#troubleshooting-upgrade-issues)

## Checking Current Version

To check your current SQLite3 version:

1. Connect to your SQLite3 container:
   ```
   docker exec -it sqlite3 /bin/sh
   ```
2. Run SQLite3 and check the version:
   ```
   sqlite3 --version
   ```

## Upgrading SQLite3

SQLite3 is typically upgraded by updating the Docker image. However, ensure compatibility with your existing data before upgrading.

## Backing Up Your Data

Before upgrading, always backup your data:

1. Stop the SQLite3 container:
   ```
   docker-compose down
   ```
2. Backup the data volume:
   ```
   docker run --rm -v sqlite3_data:/data -v $(pwd):/backup alpine tar cvf /backup/sqlite3_backup.tar /data
   ```

## Upgrading the Docker Image

1. Update the SQLITE_VERSION in your .env file to the desired version.

2. Pull the new image:

   ```
   docker-compose pull
   ```

3. Recreate the container with the new image:
   ```
   docker-compose up -d
   ```

## Post-Upgrade Steps

1. Verify the new version:

   ```
   docker exec -it sqlite3 sqlite3 --version
   ```

2. Check database integrity:

   ```
   docker exec -it sqlite3 sqlite3 /data/db.sqlite "PRAGMA integrity_check;"
   ```

3. Test your application thoroughly with the new SQLite3 version.

## Troubleshooting Upgrade Issues

- If you encounter issues after upgrading, you can revert to the previous version by changing the SQLITE_VERSION in your .env file and recreating the container.

- For data compatibility issues, consult the SQLite3 documentation for the specific version you're upgrading to.

- If problems persist, you may need to restore from your backup.

Remember to always test the upgrade process in a non-production environment before applying it to your production setup.
