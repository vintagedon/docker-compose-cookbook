# Upgrading MySQL Docker Setup

This document provides instructions for upgrading your MySQL Docker setup to a new version.

## Table of Contents

- [Upgrading MySQL Docker Setup](#upgrading-mysql-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Before You Begin](#before-you-begin)
  - [Upgrade Process](#upgrade-process)
  - [Post-Upgrade Steps](#post-upgrade-steps)
  - [Rollback Procedure](#rollback-procedure)
  - [Upgrading from Specific Versions](#upgrading-from-specific-versions)
    - [Upgrading from 5.7 to 8.0](#upgrading-from-57-to-80)
    - [Upgrading to 8.0.16 or later](#upgrading-to-8016-or-later)

## Before You Begin

1. **Backup your data**: Always create a full backup of your MySQL data before upgrading.

   ```
   docker exec mysql /usr/bin/mysqldump -u root --password=your_root_password --all-databases > backup.sql
   ```

2. **Check compatibility**: Review the MySQL documentation for any compatibility issues between your current version and the target version.

3. **Review changelog**: Check the MySQL changelog for new features, deprecated features, and behavioral changes.

4. **Test the upgrade**: Always test the upgrade process in a non-production environment first.

## Upgrade Process

1. **Stop the current container**:

   ```
   docker-compose down
   ```

2. **Update the MySQL image version** in your `docker-compose.yml` file:

   ```yaml
   services:
     mysql:
       image: mysql:new_version
   ```

3. **Pull the new image**:

   ```
   docker-compose pull
   ```

4. **Start the new container**:

   ```
   docker-compose up -d
   ```

5. **Monitor the upgrade process** by watching the logs:
   ```
   docker-compose logs -f
   ```

## Post-Upgrade Steps

1. **Verify the new version**:

   ```
   docker exec mysql mysql -u root -p -e "SELECT VERSION();"
   ```

2. **Check for errors** in the MySQL error log:

   ```
   docker exec mysql cat /var/log/mysql/error.log
   ```

3. **Run mysql_upgrade** (for versions before 8.0):

   ```
   docker exec mysql mysql_upgrade -u root -p
   ```

4. **Test your application** thoroughly to ensure compatibility with the new MySQL version.

## Rollback Procedure

If you encounter issues after upgrading, you can rollback to the previous version:

1. Stop the new container:

   ```
   docker-compose down
   ```

2. Revert the MySQL image version in `docker-compose.yml`.

3. Restore your backup:

   ```
   docker exec -i mysql mysql -u root --password=your_root_password < backup.sql
   ```

4. Start the old container:
   ```
   docker-compose up -d
   ```

## Upgrading from Specific Versions

### Upgrading from 5.7 to 8.0

- Review the [changes in MySQL 8.0](https://dev.mysql.com/doc/refman/8.0/en/upgrading-from-previous-series.html).
- Be aware of the removal of query cache in 8.0.
- Check for SQL modes that have been removed in 8.0.
- Review authentication changes, especially the default authentication plugin.

### Upgrading to 8.0.16 or later

- If you're upgrading to MySQL 8.0.16 or later, you don't need to run mysql_upgrade. The server will automatically perform the upgrade steps on startup.

Remember, upgrading a database is a critical operation. Always have a robust backup strategy and test the upgrade process thoroughly before applying it to your production environment.
