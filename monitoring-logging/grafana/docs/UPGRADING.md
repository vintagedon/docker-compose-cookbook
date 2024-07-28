# Upgrading Grafana

This document provides instructions on how to upgrade your Grafana Docker installation.

## Table of Contents

- [Upgrading Grafana](#upgrading-grafana)
  - [Table of Contents](#table-of-contents)
  - [Before You Begin](#before-you-begin)
  - [Upgrading Process](#upgrading-process)
  - [Rolling Back](#rolling-back)
  - [Post-Upgrade Steps](#post-upgrade-steps)
  - [Version-Specific Notes](#version-specific-notes)
    - [Upgrading to Grafana 8.x](#upgrading-to-grafana-8x)
    - [Upgrading to Grafana 9.x](#upgrading-to-grafana-9x)

## Before You Begin

1. **Backup your data**: Always create a backup of your Grafana data before upgrading.
2. **Check compatibility**: Review the [Grafana release notes](https://grafana.com/docs/grafana/latest/release-notes/) for any breaking changes or compatibility issues.
3. **Review system requirements**: Ensure your system meets the requirements for the new version.

## Upgrading Process

1. Update the Grafana version in your `.env` file:

```
GRAFANA_VERSION=<new_version>
```

2. Pull the new Grafana image:

```bash
docker-compose pull grafana
```

3. Stop and remove the existing Grafana container:

```bash
docker-compose stop grafana
docker-compose rm grafana
```

4. Start the new Grafana container:

```bash
docker-compose up -d grafana
```

5. Verify that Grafana is running and accessible:

```bash
docker-compose ps
```

## Rolling Back

If you encounter issues after upgrading, you can roll back to the previous version:

1. Stop the current Grafana container:

```bash
docker-compose stop grafana
```

2. Update the `GRAFANA_VERSION` in your `.env` file to the previous version.

3. Remove the current container and start a new one with the previous version:

```bash
docker-compose rm grafana
docker-compose up -d grafana
```

## Post-Upgrade Steps

1. Clear your browser cache to ensure you're seeing the latest version of the Grafana UI.
2. Check all your dashboards and data sources to ensure they're working correctly.
3. Review any new features or changes in the [Grafana documentation](https://grafana.com/docs/grafana/latest/).

## Version-Specific Notes

### Upgrading to Grafana 8.x

- Grafana 8.0 introduced a new alerting system. If you're upgrading from an earlier version, you may need to migrate your alerts. Refer to the [alerting migration guide](https://grafana.com/docs/grafana/latest/alerting/unified-alerting/migrate-alerts/) for more information.

### Upgrading to Grafana 9.x

- Grafana 9.0 removed some deprecated features. Check the [release notes](https://grafana.com/docs/grafana/latest/release-notes/release-notes-9-0-0/) for details on removed features and how to adapt your setup if necessary.

Remember, it's always a good practice to test the upgrade process in a non-production environment before applying it to your production setup.

For more detailed upgrade information, please refer to the [official Grafana upgrade guide](https://grafana.com/docs/grafana/latest/setup-grafana/upgrade-grafana/).
