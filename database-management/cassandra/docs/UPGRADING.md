# Upgrading Cassandra Docker Setup

This guide provides instructions for upgrading your Cassandra Docker setup to a new version.

## Before You Begin

1. **Backup Your Data**: Always create a full backup of your data before upgrading.

   ```
   docker exec -it cassandra nodetool snapshot
   ```

2. **Check Compatibility**: Ensure that your application is compatible with the new Cassandra version.

3. **Review Release Notes**: Check the release notes for the new version for any breaking changes or new features.

4. **Plan for Downtime**: While rolling upgrades are possible, plan for potential downtime.

## Upgrade Process for Single Node Setup

1. Stop the current Cassandra container:

   ```
   docker-compose stop cassandra
   ```

2. Update the Cassandra version in your `docker-compose.yml` file:

   ```yaml
   services:
     cassandra:
       image: cassandra:new_version
   ```

3. Pull the new Cassandra image:

   ```
   docker-compose pull cassandra
   ```

4. Start the new Cassandra container:

   ```
   docker-compose up -d cassandra
   ```

5. Wait for Cassandra to start and then check the status:

   ```
   docker exec -it cassandra nodetool status
   ```

6. Upgrade the SSTables:
   ```
   docker exec -it cassandra nodetool upgradesstables
   ```

## Upgrade Process for Multi-Node Cluster

For a multi-node cluster, you'll want to perform a rolling upgrade:

1. Disable auto-bootstrap in `cassandra.yaml` for all nodes:

   ```yaml
   auto_bootstrap: false
   ```

2. Upgrade one node at a time, starting with the seed nodes:

   - Stop the node
   - Update the Cassandra version in `docker-compose.yml`
   - Start the node with the new version
   - Wait for the node to be fully up (check with `nodetool status`)
   - Upgrade SSTables on the node: `nodetool upgradesstables`

3. Repeat step 2 for each node in the cluster.

4. Once all nodes are upgraded, re-enable auto-bootstrap:
   ```yaml
   auto_bootstrap: true
   ```

## Post-Upgrade Steps

1. Verify cluster health:

   ```
   docker exec -it cassandra nodetool status
   docker exec -it cassandra nodetool tablestats
   ```

2. Run a full `nodetool repair` on each node.

3. Test your application thoroughly to ensure compatibility with the new version.

4. Monitor the cluster closely for the next few days to catch any potential issues.

## Downgrade Procedure

If you encounter issues and need to downgrade:

1. Stop the Cassandra container.
2. Revert to the previous version in your `docker-compose.yml`.
3. Start the container with the previous version.
4. Restore data from the backup if necessary.

Note: Downgrading may not always be possible, especially if the new version made changes to the data format. Always consult the Cassandra documentation for version-specific downgrade instructions.

## Troubleshooting Upgrade Issues

- If a node fails to start after upgrade, check the logs:

  ```
  docker logs cassandra
  ```

- If you encounter schema disagreements:

  ```
  docker exec -it cassandra nodetool describecluster
  ```

- For data inconsistencies, run a full repair:
  ```
  docker exec -it cassandra nodetool repair
  ```

Remember, upgrading a database is a critical operation. Always test the upgrade process in a staging environment before applying it to production.

For more detailed information on upgrading Cassandra, refer to the official Apache Cassandra documentation.
