# Upgrading Guide for Jenkins with SQLite3

This document provides instructions for upgrading your Jenkins with SQLite3 Docker setup.

## Table of Contents

- [Upgrading Guide for Jenkins with SQLite3](#upgrading-guide-for-jenkins-with-sqlite3)
  - [Table of Contents](#table-of-contents)
  - [Before You Begin](#before-you-begin)
  - [Upgrading Jenkins](#upgrading-jenkins)
  - [Upgrading SQLite3](#upgrading-sqlite3)
  - [Upgrading Plugins](#upgrading-plugins)
  - [Rollback Procedure](#rollback-procedure)

## Before You Begin

1. **Backup your data**: Always create a full backup of your Jenkins home directory and SQLite database before upgrading.

2. **Review release notes**: Check the [Jenkins changelog](https://www.jenkins.io/changelog/) for any breaking changes or new features.

3. **Check plugin compatibility**: Ensure your installed plugins are compatible with the new Jenkins version.

4. **Plan for downtime**: Upgrading will require Jenkins to be offline for a period of time.

## Upgrading Jenkins

1. Update the Jenkins version in your `.env` file:

   ```
   JENKINS_VERSION=<new_version>
   ```

2. Pull the new Jenkins Docker image:

   ```
   docker-compose pull
   ```

3. Stop and remove the existing Jenkins container:

   ```
   docker-compose down
   ```

4. Start the new Jenkins container:

   ```
   docker-compose up -d
   ```

5. Monitor the logs for any errors:

   ```
   docker-compose logs -f jenkins
   ```

6. Access the Jenkins web interface and verify the upgrade was successful.

## Upgrading SQLite3

SQLite3 is typically upgraded as part of the Jenkins Docker image update. However, if you need to upgrade SQLite3 separately:

1. Backup your SQLite database:

   ```
   docker exec jenkins sqlite3 /var/jenkins_sqlite/jenkins.db ".backup '/var/jenkins_sqlite/jenkins_backup.db'"
   ```

2. Update the SQLite3 version in your Dockerfile (if you're using a custom image).

3. Rebuild and restart the Jenkins container:

   ```
   docker-compose up -d --build
   ```

4. Verify the new SQLite3 version:
   ```
   docker exec jenkins sqlite3 --version
   ```

## Upgrading Plugins

1. Go to "Manage Jenkins" > "Manage Plugins".

2. Select the plugins you wish to upgrade.

3. Click "Download now and install after restart".

4. Check the option to "Restart Jenkins when installation is complete and no jobs are running".

5. Monitor the upgrade process and check logs for any errors.

## Rollback Procedure

If you encounter issues after upgrading, you can rollback to the previous version:

1. Stop the Jenkins container:

   ```
   docker-compose down
   ```

2. Restore your backup of the Jenkins home directory and SQLite database.

3. Update the `.env` file to the previous Jenkins version.

4. Start Jenkins with the previous version:

   ```
   docker-compose up -d
   ```

5. Verify that Jenkins is functioning correctly with the restored data.

Always test upgrades in a staging environment before applying them to production. If you encounter any issues during the upgrade process, consult the [Jenkins upgrade documentation](https://www.jenkins.io/doc/upgrade-guide/) or seek help from the Jenkins community.
