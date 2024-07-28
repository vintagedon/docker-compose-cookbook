# Upgrading Guide for Wireguard Docker Setup

This document outlines the process for upgrading your Wireguard Docker setup to newer versions.

## Before Upgrading

1. **Backup Your Configuration**:

   ```bash
   cp -r ./config ./config_backup_$(date +%Y%m%d)
   ```

2. **Check for Breaking Changes**:
   Review the [linuxserver/wireguard](https://github.com/linuxserver/docker-wireguard) GitHub repository for any breaking changes in recent releases.

3. **Update Your Local Repository**:
   If you cloned this repository, update it:
   ```bash
   git pull origin main
   ```

## Upgrading Process

1. **Update the Docker Image**:

   ```bash
   docker-compose pull wireguard
   ```

2. **Recreate the Container**:

   ```bash
   docker-compose up -d --force-recreate wireguard
   ```

3. **Check the Logs**:

   ```bash
   docker-compose logs wireguard
   ```

   Ensure there are no error messages and the service has started correctly.

4. **Verify Connectivity**:
   Test your Wireguard connections to ensure they're working as expected.

## After Upgrading

1. **Clean Up Old Images**:
   Remove old, unused Docker images to free up space:

   ```bash
   docker image prune
   ```

2. **Update Client Configurations**:
   If there were any changes to the server configuration, update your client configurations accordingly.

3. **Review Security Settings**:
   Check the [SECURITY.md](SECURITY.md) file for any new recommendations.

## Troubleshooting Upgrade Issues

If you encounter issues after upgrading:

1. **Check Logs**:
   Review the Docker logs for any error messages:

   ```bash
   docker-compose logs wireguard
   ```

2. **Verify Configuration**:
   Ensure your `.env` file and `docker-compose.yml` are compatible with the new version.

3. **Rollback if Necessary**:
   If you experience persistent issues, you can rollback to the previous version:

   ```bash
   docker-compose down
   docker-compose up -d --force-recreate wireguard
   ```

4. **Seek Help**:
   If problems persist, check the [Troubleshooting Guide](TROUBLESHOOTING.md) or seek help in the Wireguard or Docker communities.

## Keeping Updated

To stay informed about new releases and potential security updates:

1. Watch the [linuxserver/docker-wireguard](https://github.com/linuxserver/docker-wireguard) GitHub repository.
2. Regularly check for updates to this setup repository.
3. Consider setting up automated updates with tools like Watchtower, but be cautious as automatic updates can sometimes lead to unexpected issues.

Remember, while staying updated is important for security and new features, always test upgrades in a non-production environment first if possible.
