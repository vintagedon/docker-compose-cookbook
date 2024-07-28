# Upgrading Guide for AdGuard Home Docker Setup

This document provides instructions for upgrading your AdGuard Home Docker setup to newer versions.

## Before Upgrading

1. Backup your configuration:

   ```
   docker cp adguardhome:/opt/adguardhome/conf ./adguardhome_conf_backup
   ```

2. Check the release notes for the new version:
   https://github.com/AdguardTeam/AdGuardHome/releases

3. Ensure your Docker and Docker Compose are up to date

## Upgrading Process

### Using Docker Compose

1. Update the image version in your docker-compose.yml file:

   ```yaml
   services:
     adguardhome:
       image: adguard/adguardhome:latest # Or specify a version
   ```

2. Pull the new image:

   ```
   docker-compose pull adguardhome
   ```

3. Recreate the container:
   ```
   docker-compose up -d --force-recreate adguardhome
   ```

### Manual Docker Commands

1. Stop the current container:

   ```
   docker stop adguardhome
   ```

2. Remove the old container:

   ```
   docker rm adguardhome
   ```

3. Pull the new image:

   ```
   docker pull adguard/adguardhome:latest
   ```

4. Create a new container with the updated image:
   ```
   docker run -d \
     --name adguardhome \
     -p 53:53/tcp -p 53:53/udp \
     -p 3000:3000/tcp \
     -v /path/to/workdir:/opt/adguardhome/work \
     -v /path/to/confdir:/opt/adguardhome/conf \
     --restart unless-stopped \
     adguard/adguardhome:latest
   ```

## Post-Upgrade Steps

1. Verify the new version is running:

   ```
   docker exec adguardhome /opt/adguardhome/AdGuardHome --version
   ```

2. Check the logs for any errors:

   ```
   docker logs adguardhome
   ```

3. Access the web interface and verify your settings

4. Test DNS resolution and filtering

## Rollback Procedure

If you encounter issues after upgrading:

1. Stop and remove the new container
2. Revert to the previous image version in your docker-compose.yml or docker run command
3. Recreate the container with the old image
4. Restore your configuration from the backup if necessary

Remember to always keep backups of your configuration and test thoroughly after upgrading.
