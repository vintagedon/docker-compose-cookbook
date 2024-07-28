# Upgrading Cacti with MySQL

This guide provides instructions for upgrading your Cacti with MySQL Docker setup.

## Table of Contents

- [Upgrading Cacti with MySQL](#upgrading-cacti-with-mysql)
  - [Table of Contents](#table-of-contents)
  - [Before You Begin](#before-you-begin)
  - [Upgrade Steps](#upgrade-steps)
  - [Post-Upgrade Tasks](#post-upgrade-tasks)
  - [Troubleshooting](#troubleshooting)
  - [Rollback Procedure](#rollback-procedure)

## Before You Begin

1. **Backup your data**

   - Export Cacti configuration
   - Backup MySQL database
   - Backup RRD files

2. **Check compatibility**

   - Review Cacti release notes for any breaking changes
   - Verify plugin compatibility with the new Cacti version

3. **Plan downtime**
   - Inform users of potential monitoring disruption

## Upgrade Steps

1. **Update Docker images**

   ```bash
   docker-compose pull
   ```

2. **Stop the current setup**

   ```bash
   docker-compose down
   ```

3. **Update docker-compose.yml**

   - Modify the Cacti image version if necessary
   - Update any environment variables or volume mappings

4. **Start the updated setup**

   ```bash
   docker-compose up -d
   ```

5. **Run Cacti upgrade script**
   ```bash
   docker exec cacti_container_name php /var/www/html/cacti/cli/upgrade_database.php
   ```

## Post-Upgrade Tasks

1. **Verify Cacti version**

   - Check Cacti web interface for the new version number

2. **Review logs**

   - Check for any errors in Cacti and MySQL logs

3. **Test functionality**

   - Verify data collection is working
   - Check graph generation
   - Test any custom scripts or plugins

4. **Update plugins**

   - Upgrade any plugins to versions compatible with the new Cacti

5. **Optimize performance**
   - Review and apply any new performance recommendations

## Troubleshooting

1. **Database upgrade issues**

   - Review Cacti upgrade log
   - Manually run any failed SQL updates

2. **Plugin compatibility**

   - Disable incompatible plugins
   - Check for plugin updates

3. **Data collection problems**
   - Verify poller is running correctly
   - Check device templates for any necessary updates

## Rollback Procedure

If the upgrade fails:

1. Stop the Docker containers

   ```bash
   docker-compose down
   ```

2. Restore the MySQL database backup
3. Restore the RRD files
4. Revert docker-compose.yml to the previous version
5. Start the previous version
   ```bash
   docker-compose up -d
   ```

Always test the upgrade process in a non-production environment first. If you encounter persistent issues, consult the Cacti forums or seek professional support.
