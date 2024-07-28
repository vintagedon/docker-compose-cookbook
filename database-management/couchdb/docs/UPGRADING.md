# Upgrading Guide for CouchDB Docker Setup

This document provides instructions for upgrading your CouchDB Docker setup to a new version.

## Before You Begin

1. **Backup Your Data**: Always create a backup of your data before upgrading.

   ```
   docker exec couchdb couchdb-backup /opt/couchdb/data /backup
   ```

2. **Check Compatibility**: Review the release notes of the new CouchDB version for any breaking changes or compatibility issues.

3. **Plan for Downtime**: Upgrading may require some downtime. Plan accordingly.

## Upgrading Process

### 1. Single Node Setup

1. Stop the current CouchDB container:

   ```
   docker-compose down
   ```

2. Update the CouchDB version in your `docker-compose.yml`:

   ```yaml
   image: couchdb:new_version
   ```

3. Pull the new image:

   ```
   docker-compose pull
   ```

4. Start the container with the new version:

   ```
   docker-compose up -d
   ```

5. Verify the new version:
   ```
   curl http://admin:password@localhost:5984
   ```

### 2. Cluster Setup

For a clustered setup, you'll need to upgrade each node separately:

1. Remove a node from the cluster:

   ```
   curl -X DELETE "http://admin:password@localhost:5984/_node/_local/_nodes/couchdb@node_to_upgrade" -H "Content-Type: application/json"
   ```

2. Stop the container on that node:

   ```
   docker-compose down
   ```

3. Update the CouchDB version in `docker-compose.yml` on that node.

4. Start the container with the new version:

   ```
   docker-compose up -d
   ```

5. Add the node back to the cluster:

   ```
   curl -X PUT "http://admin:password@localhost:5984/_node/_local/_nodes/couchdb@upgraded_node" -H "Content-Type: application/json"
   ```

6. Repeat for each node in the cluster.

## Post-Upgrade Steps

1. **Verify Data Integrity**: Check that all your databases and documents are intact.

2. **Update Indexes**: Rebuild any custom indexes if necessary.

3. **Check Performance**: Monitor the performance to ensure it meets expectations with the new version.

4. **Update Client Applications**: If there are any API changes, update your client applications accordingly.

## Rollback Procedure

If you encounter issues after upgrading, you may need to rollback:

1. Stop the new container:

   ```
   docker-compose down
   ```

2. Revert the CouchDB version in `docker-compose.yml` to the previous version.

3. Start the container with the old version:

   ```
   docker-compose up -d
   ```

4. Restore your data from the backup if necessary.

## Version-Specific Upgrade Notes

### Upgrading to 3.x from 2.x

- CouchDB 3.x introduces significant changes. Review the [official upgrade notes](https://docs.couchdb.org/en/stable/install/upgrading.html) carefully.
- You may need to migrate your data to the new file format.

### Upgrading within 3.x

- Generally, upgrades within the 3.x series are smoother but still require careful testing.

Remember to always refer to the official CouchDB documentation for the most up-to-date and detailed upgrading instructions.
