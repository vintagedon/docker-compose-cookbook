# Upgrading Guide for Graylog Docker Setup

This document provides instructions for upgrading your Graylog Docker setup to newer versions.

## Table of Contents

- [Upgrading Guide for Graylog Docker Setup](#upgrading-guide-for-graylog-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Before You Begin](#before-you-begin)
  - [Upgrade Process](#upgrade-process)
  - [Version-Specific Upgrade Notes](#version-specific-upgrade-notes)
    - [Upgrading to Graylog 4.x](#upgrading-to-graylog-4x)
    - [Upgrading to Graylog 3.x](#upgrading-to-graylog-3x)
  - [Rollback Procedure](#rollback-procedure)
  - [Post-Upgrade Steps](#post-upgrade-steps)

## Before You Begin

- Read the release notes for the version you're upgrading to.
- Backup your data (Graylog, Elasticsearch, and MongoDB).
- Plan for downtime during the upgrade process.
- Test the upgrade procedure in a non-production environment first.

## Upgrade Process

1. Update the version numbers in your `.env` file:

   ```
   GRAYLOG_VERSION=X.X.X
   ES_VERSION=X.X.X
   MONGO_VERSION=X.X
   ```

2. Pull the new Docker images:

   ```
   docker-compose pull
   ```

3. Stop the current setup:

   ```
   docker-compose down
   ```

4. Start the updated setup:

   ```
   docker-compose up -d
   ```

5. Monitor the logs for any errors:

   ```
   docker-compose logs -f
   ```

## Version-Specific Upgrade Notes

### Upgrading to Graylog 4.x

- Elasticsearch 7.x is required.
- Review the [Graylog 4.0 upgrade notes](https://docs.graylog.org/en/4.0/pages/upgrade/graylog-4.0.html).

### Upgrading to Graylog 3.x

- Elasticsearch 6.x or 7.x is required.
- MongoDB 3.6 or later is required.
- Review the [Graylog 3.0 upgrade notes](https://docs.graylog.org/en/3.0/pages/upgrade/graylog-3.0.html).

## Rollback Procedure

If issues occur during the upgrade:

1. Stop the containers:

   ```
   docker-compose down
   ```

2. Revert the version numbers in your `.env` file to the previous values.

3. Start the containers with the old versions:

   ```
   docker-compose up -d
   ```

4. Restore data from backups if necessary.

## Post-Upgrade Steps

1. Verify that all inputs are receiving data.
2. Check that all streams and alerts are functioning correctly.
3. Test any custom scripts or integrations.
4. Review and update any deprecated configuration settings.

Remember to always refer to the official Graylog documentation for the most up-to-date and comprehensive upgrade instructions.
