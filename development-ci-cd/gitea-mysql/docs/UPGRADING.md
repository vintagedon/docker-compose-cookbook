# Upgrading Guide for Gitea with MySQL Docker Setup

This document outlines the process for upgrading your Gitea instance with MySQL using Docker.

## Table of Contents

- [Upgrading Guide for Gitea with MySQL Docker Setup](#upgrading-guide-for-gitea-with-mysql-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Before You Begin](#before-you-begin)
  - [Backup](#backup)
  - [Upgrade Process](#upgrade-process)
  - [Post-Upgrade Steps](#post-upgrade-steps)
  - [Troubleshooting](#troubleshooting)
  - [Rollback Procedure](#rollback-procedure)

## Before You Begin

1. Check the [Gitea release notes](https://github.com/go-gitea/gitea/releases) for any breaking changes or special upgrade instructions.
2. Ensure you have sufficient disk space for the upgrade process.
3. Plan for a maintenance window, as Gitea will be unavailable during the upgrade.

## Backup

Before upgrading, always create a full backup of your data:

1. Back up Gitea data:

   ```
   docker run --rm -v gitea_data:/data -v $(pwd):/backup alpine tar czf /backup/gitea_data_backup_$(date +%Y%m%d).tar.gz /data
   ```

2. Back up MySQL database:
   ```
   docker exec gitea-mysql mysqldump -u root -p<MYSQL_ROOT_PASSWORD> --all-databases > mysql_backup_$(date +%Y%m%d).sql
   ```

## Upgrade Process

1. Stop the current Gitea and MySQL containers:

   ```
   docker-compose down
   ```

2. Update the Gitea version in your `docker-compose.yml` file:

   ```yaml
   gitea:
     image: gitea/gitea:latest # Replace 'latest' with the specific version if desired
   ```

3. Pull the new Gitea image:

   ```
   docker-compose pull gitea
   ```

4. Start the containers with the new image:

   ```
   docker-compose up -d
   ```

5. Monitor the logs for any errors:
   ```
   docker-compose logs -f gitea
   ```

## Post-Upgrade Steps

1. Verify that Gitea is running correctly by accessing the web interface.

2. Check the Gitea logs for any warnings or errors:

   ```
   docker-compose logs gitea
   ```

3. Run Gitea's built-in check for changed configuration options:

   ```
   docker-compose exec gitea gitea doctor check --config /data/gitea/conf/app.ini
   ```

4. Update any custom templates or plugins if necessary.

5. Inform users that the upgrade is complete and ask them to report any issues.

## Troubleshooting

If you encounter issues during or after the upgrade:

1. Check the Gitea logs for specific error messages:

   ```
   docker-compose logs gitea
   ```

2. Verify that the MySQL connection is working correctly.

3. Ensure all volumes are properly mounted and accessible.

4. Check for any incompatibilities between Gitea and MySQL versions.

5. Consult the [Gitea documentation](https://docs.gitea.io/) or community forums for specific error messages.

## Rollback Procedure

If the upgrade fails and you need to rollback:

1. Stop the containers:

   ```
   docker-compose down
   ```

2. Revert the Gitea version in your `docker-compose.yml` file to the previous version.

3. Restore the Gitea data backup:

   ```
   docker run --rm -v gitea_data:/data -v $(pwd):/backup alpine sh -c "rm -rf /data/* /data/..?* /data/.[!.]* ; tar xzf /backup/gitea_data_backup_YYYYMMDD.tar.gz -C /"
   ```

4. Restore the MySQL database backup:

   ```
   docker exec -i gitea-mysql mysql -u root -p<MYSQL_ROOT_PASSWORD> < mysql_backup_YYYYMMDD.sql
   ```

5. Start the containers with the old version:
   ```
   docker-compose up -d
   ```

Remember to replace `YYYYMMDD` with the actual date of your backup files.

Always test the upgrade process in a staging environment before applying it to your production instance. Regular backups and a well-documented upgrade process are key to successful Gitea maintenance.
