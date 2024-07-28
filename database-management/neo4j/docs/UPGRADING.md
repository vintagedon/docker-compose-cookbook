# Upgrading Guide for Neo4j Docker Setup

This guide provides instructions for upgrading your Neo4j Docker instance.

## Table of Contents

- [Upgrading Guide for Neo4j Docker Setup](#upgrading-guide-for-neo4j-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Before You Begin](#before-you-begin)
  - [Upgrading Process](#upgrading-process)
  - [Post-Upgrade Steps](#post-upgrade-steps)
  - [Rollback Procedure](#rollback-procedure)
  - [Upgrading from Specific Versions](#upgrading-from-specific-versions)
    - [3.5.x to 4.x](#35x-to-4x)
    - [4.x to 4.y](#4x-to-4y)

## Before You Begin

1. Backup your data:
   ```
   docker exec <container_name> neo4j-admin dump --database=neo4j --to=/backups/neo4j-backup.dump
   ```
2. Review the [Neo4j Migration Guide](https://neo4j.com/docs/upgrade-migration-guide/current/) for any breaking changes.
3. Check plugin compatibility with the new Neo4j version.

## Upgrading Process

1. Update the Neo4j version in your `.env` file:

   ```
   NEO4J_VERSION=<new_version>
   ```

2. Pull the new Neo4j image:

   ```
   docker-compose pull
   ```

3. Stop and remove the existing container:

   ```
   docker-compose down
   ```

4. Start the new container:

   ```
   docker-compose up -d
   ```

5. Monitor the logs for any errors:
   ```
   docker-compose logs -f
   ```

## Post-Upgrade Steps

1. Verify the new version:

   ```
   docker exec <container_name> neo4j --version
   ```

2. Check database status:

   ```
   docker exec <container_name> cypher-shell "CALL dbms.components() YIELD name, versions, edition"
   ```

3. Run consistency check:
   ```
   docker exec <container_name> neo4j-admin check-consistency --database=neo4j
   ```

## Rollback Procedure

If issues occur:

1. Stop the new container:

   ```
   docker-compose down
   ```

2. Revert the NEO4J_VERSION in `.env`

3. Start the old container:

   ```
   docker-compose up -d
   ```

4. Restore from backup if necessary:
   ```
   docker exec <container_name> neo4j-admin load --from=/backups/neo4j-backup.dump --database=neo4j --force
   ```

## Upgrading from Specific Versions

### 3.5.x to 4.x

- Requires a dump and load process
- [Follow Neo4j's official guide](https://neo4j.com/docs/upgrade-migration-guide/current/version-4/migration/dump-load/)

### 4.x to 4.y

- In-place upgrade is usually possible
- Always refer to the specific version's upgrade notes

Remember to always test the upgrade process in a non-production environment first.
