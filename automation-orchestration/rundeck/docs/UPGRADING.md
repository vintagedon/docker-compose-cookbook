# Upgrading Guide for Rundeck Docker Setup

This guide provides instructions for upgrading your Rundeck Docker installation.

## Before You Begin

1. **Backup Your Data**: Always backup your data before upgrading.

   ```
   docker-compose exec db mysqldump -u root -p rundeck > rundeck_backup.sql
   ```

2. **Check Compatibility**: Review the [Rundeck upgrade guide](https://docs.rundeck.com/docs/upgrading/) for your target version.

3. **Review Changes**: Check the [Rundeck release notes](https://docs.rundeck.com/docs/history/) for any breaking changes or new features.

## Upgrade Process

### 1. Update Rundeck Version

Update the `RUNDECK_VERSION` in your `.env` file:

```
RUNDECK_VERSION=X.Y.Z
```

Replace `X.Y.Z` with the desired Rundeck version.

### 2. Pull New Images

Pull the new Rundeck and MariaDB images:

```
docker-compose pull
```

### 3. Stop the Current Setup

```
docker-compose down
```

### 4. Start with New Version

```
docker-compose up -d
```

### 5. Check Logs for Any Issues

```
docker-compose logs -f rundeck
```

### 6. Verify Upgrade

Access the Rundeck web interface and check the version number under "System Report".

## Post-Upgrade Tasks

1. **Test Functionality**: Verify that all projects, jobs, and integrations are working as expected.

2. **Update Plugins**: Check if any plugins need to be updated for compatibility with the new Rundeck version.

3. **Review Configuration**: Some upgrades may introduce new configuration options. Review and update your `rundeck-config.properties` if necessary.

4. **Clear Cache**: You may need to clear browser cache to see UI changes.

## Troubleshooting

If you encounter issues after upgrading:

1. Check the Rundeck logs for error messages:

   ```
   docker-compose logs rundeck
   ```

2. Verify database connectivity:

   ```
   docker-compose exec rundeck java -jar /home/rundeck/client/lib/rundeck-cli-X.Y.Z.jar --url http://localhost:4440 system info
   ```

3. If problems persist, consider rolling back to the previous version and restoring from your backup.

## Rolling Back

If you need to roll back to a previous version:

1. Stop the current setup:

   ```
   docker-compose down
   ```

2. Update the `RUNDECK_VERSION` in your `.env` file to the previous version.

3. Restore your database from the backup:

   ```
   docker-compose up -d db
   docker-compose exec -T db mysql -u root -p rundeck < rundeck_backup.sql
   ```

4. Start Rundeck with the previous version:
   ```
   docker-compose up -d
   ```

Always refer to the official Rundeck documentation for the most up-to-date and version-specific upgrade instructions.
