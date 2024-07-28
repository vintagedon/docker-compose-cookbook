# Upgrading Guide for Prometheus Docker Setup

This document provides guidelines on upgrading Prometheus to newer versions in your Docker environment.

## Table of Contents

- [Upgrading Guide for Prometheus Docker Setup](#upgrading-guide-for-prometheus-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Before You Upgrade](#before-you-upgrade)
  - [Upgrade Process](#upgrade-process)
  - [Post-Upgrade Steps](#post-upgrade-steps)
  - [Rollback Procedure](#rollback-procedure)
  - [Version-Specific Considerations](#version-specific-considerations)

## Before You Upgrade

1. **Backup Your Data**: Always backup your Prometheus data before upgrading:

   ```
   docker run --rm -v prometheus_data:/source -v /path/on/host:/backup ubuntu tar czf /backup/prometheus_backup.tar.gz /source
   ```

2. **Check Release Notes**: Review the [Prometheus release notes](https://github.com/prometheus/prometheus/releases) for any breaking changes or new features.

3. **Test in Non-Production**: If possible, test the upgrade in a non-production environment first.

## Upgrade Process

1. **Update Docker Image**: Modify your `docker-compose.yml` to use the new Prometheus version:

   ```yaml
   services:
     prometheus:
       image: prom/prometheus:v2.x.y # Replace x.y with the new version number
   ```

2. **Pull New Image**: Pull the new Prometheus image:

   ```
   docker-compose pull prometheus
   ```

3. **Restart Container**: Restart the Prometheus container with the new image:
   ```
   docker-compose up -d prometheus
   ```

## Post-Upgrade Steps

1. **Verify Prometheus is Running**: Check the container status:

   ```
   docker-compose ps prometheus
   ```

2. **Check Prometheus Logs**: Look for any errors in the logs:

   ```
   docker-compose logs prometheus
   ```

3. **Verify Metrics Collection**: Ensure Prometheus is still collecting metrics from all targets.

4. **Test Queries and Alerts**: Verify that your important queries and alerts are still working as expected.

## Rollback Procedure

If you encounter issues after upgrading:

1. Stop the Prometheus container:

   ```
   docker-compose stop prometheus
   ```

2. Revert to the previous version in your `docker-compose.yml`.

3. Restore your data from the backup:

   ```
   docker run --rm -v prometheus_data:/target -v /path/on/host:/backup ubuntu bash -c "cd /target && tar xzvf /backup/prometheus_backup.tar.gz --strip 1"
   ```

4. Start Prometheus with the previous version:
   ```
   docker-compose up -d prometheus
   ```

## Version-Specific Considerations

- **2.x to 3.x**: Major version upgrades may include breaking changes. Always refer to the official migration guide.
- **Minor Version Upgrades**: These are usually backwards compatible but may include new features or performance improvements.
- **Patch Version Upgrades**: These typically include bug fixes and are safe to apply.

Always refer to the official Prometheus documentation for the most up-to-date and detailed upgrading instructions.
