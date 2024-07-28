# Backup and Restore Guide for Gitea with MySQL Docker Setup

This document outlines the procedures for backing up and restoring your Gitea instance with MySQL using Docker.

## Table of Contents

- [Backup and Restore Guide for Gitea with MySQL Docker Setup](#backup-and-restore-guide-for-gitea-with-mysql-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Backup](#backup)
    - [Gitea Data](#gitea-data)
    - [MySQL Database](#mysql-database)
  - [Restore](#restore)
    - [Gitea Data](#gitea-data-1)
    - [MySQL Database](#mysql-database-1)
  - [Automated Backups](#automated-backups)
  - [Best Practices](#best-practices)

## Backup

### Gitea Data

1. Stop the Gitea container:

   ```
   docker-compose stop gitea
   ```

2. Backup the Gitea data volume:
   ```
   docker run --rm -v gitea_data:/data -v $(pwd):/backup alpine tar czf /backup/gitea_data_backup.tar.gz /data
   ```

### MySQL Database

1. Use `mysqldump` to create a backup of the database:

   ```
   docker exec gitea-mysql mysqldump -u root -p<MYSQL_ROOT_PASSWORD> --all-databases > mysql_backup.sql
   ```

   Replace `<MYSQL_ROOT_PASSWORD>` with your actual MySQL root password.

## Restore

### Gitea Data

1. Stop the Gitea container:

   ```
   docker-compose stop gitea
   ```

2. Restore the Gitea data volume:
   ```
   docker run --rm -v gitea_data:/data -v $(pwd):/backup alpine sh -c "rm -rf /data/* /data/..?* /data/.[!.]* ; tar xzf /backup/gitea_data_backup.tar.gz -C /"
   ```

### MySQL Database

1. Stop the MySQL container:

   ```
   docker-compose stop mysql
   ```

2. Restore the MySQL data:

   ```
   docker exec -i gitea-mysql mysql -u root -p<MYSQL_ROOT_PASSWORD> < mysql_backup.sql
   ```

   Replace `<MYSQL_ROOT_PASSWORD>` with your actual MySQL root password.

3. Restart the containers:
   ```
   docker-compose up -d
   ```

## Automated Backups

You can create a shell script to automate the backup process. Here's a simple example:

```bash
#!/bin/bash

# Set variables
BACKUP_DIR="/path/to/backup/directory"
MYSQL_ROOT_PASSWORD="your_mysql_root_password"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Backup Gitea data
docker run --rm -v gitea_data:/data -v $BACKUP_DIR:/backup alpine tar czf /backup/gitea_data_backup_$(date +%Y%m%d).tar.gz /data

# Backup MySQL database
docker exec gitea-mysql mysqldump -u root -p$MYSQL_ROOT_PASSWORD --all-databases > $BACKUP_DIR/mysql_backup_$(date +%Y%m%d).sql

# Optional: Remove backups older than 7 days
find $BACKUP_DIR -name "gitea_data_backup_*.tar.gz" -mtime +7 -delete
find $BACKUP_DIR -name "mysql_backup_*.sql" -mtime +7 -delete
```

You can schedule this script to run regularly using cron.

## Best Practices

1. Perform backups regularly
2. Store backups in a secure, offsite location
3. Test your restore process periodically
4. Keep multiple backup versions
5. Encrypt sensitive backup data
6. Monitor the backup process and set up alerts for failures

Remember to adjust paths and passwords according to your specific setup.
