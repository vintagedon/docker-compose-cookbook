# Upgrading Guide for Pi-hole Docker Setup

This document provides instructions for upgrading your Pi-hole Docker installation to the latest version.

## Table of Contents

- [Upgrading Guide for Pi-hole Docker Setup](#upgrading-guide-for-pi-hole-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Before You Begin](#before-you-begin)
  - [Backup Procedure](#backup-procedure)
  - [Upgrade Process](#upgrade-process)
  - [Post-Upgrade Steps](#post-upgrade-steps)
  - [Troubleshooting](#troubleshooting)
  - [Rollback Procedure](#rollback-procedure)

## Before You Begin

- Check the [Pi-hole release notes](https://github.com/pi-hole/pi-hole/releases) for any breaking changes or special upgrade instructions.
- Ensure you have enough disk space for the upgrade.
- Plan for a maintenance window as DNS services will be briefly interrupted.

## Backup Procedure

1. **Stop the Pi-hole container**:

   ```
   docker-compose stop pihole
   ```

2. **Backup volumes**:

   ```
   sudo tar -czf pihole_backup_$(date +%Y%m%d).tar.gz -C /path/to/pihole/volumes .
   ```

3. **Backup docker-compose.yml and .env files**:
   ```
   cp docker-compose.yml docker-compose.yml.bak
   cp .env .env.bak
   ```

## Upgrade Process

1. **Pull the latest Pi-hole image**:

   ```
   docker-compose pull pihole
   ```

2. **Update docker-compose.yml** (if necessary):

   - Check for any new environment variables or volume mounts in the latest version.
   - Update your `docker-compose.yml` file accordingly.

3. **Restart the container with the new image**:

   ```
   docker-compose up -d pihole
   ```

4. **Check the container logs for any errors**:
   ```
   docker-compose logs pihole
   ```

## Post-Upgrade Steps

1. **Verify Pi-hole functionality**:

   - Access the web interface and check if it loads correctly.
   - Try blocking an ad to ensure ad-blocking is working.

2. **Update gravity**:

   ```
   docker exec pihole pihole -g
   ```

3. **Check Pi-hole version**:

   ```
   docker exec pihole pihole -v
   ```

4. **Review and update custom configurations** (if any):
   - Check if any of your custom configurations need adjustments due to the upgrade.

## Troubleshooting

If you encounter issues after upgrading:

1. **Check container logs**:

   ```
   docker-compose logs pihole
   ```

2. **Verify container is running**:

   ```
   docker-compose ps
   ```

3. **Restart the container**:

   ```
   docker-compose restart pihole
   ```

4. **Check Pi-hole debug log**:
   ```
   docker exec pihole pihole -d
   ```

## Rollback Procedure

If the upgrade causes issues that can't be resolved:

1. **Stop the current container**:

   ```
   docker-compose stop pihole
   ```

2. **Restore backup files**:

   ```
   sudo rm -rf /path/to/pihole/volumes/*
   sudo tar -xzf pihole_backup_YYYYMMDD.tar.gz -C /path/to/pihole/volumes
   cp docker-compose.yml.bak docker-compose.yml
   cp .env.bak .env
   ```

3. **Revert to the previous image**:

   - Edit `docker-compose.yml` to specify the previous version.

4. **Start the container**:

   ```
   docker-compose up -d pihole
   ```

5. **Verify functionality** as described in the Post-Upgrade Steps.

Always test thoroughly after an upgrade or rollback to ensure your Pi-hole is functioning correctly.
