# Troubleshooting Guide for CouchDB Docker Setup

This guide provides solutions to common issues you might encounter with your CouchDB Docker setup.

## 1. Container Fails to Start

**Symptom:** The CouchDB container stops immediately after starting.

**Possible Solutions:**

1. Check Docker logs:
   ```
   docker logs couchdb
   ```
2. Ensure you have the correct permissions on your data volume:
   ```
   sudo chown -R 5984:5984 /path/to/couchdb/data
   ```
3. Verify your environment variables in the `.env` file.

## 2. Cannot Connect to CouchDB

**Symptom:** Unable to connect to CouchDB on the specified port.

**Possible Solutions:**

1. Check if the container is running:
   ```
   docker ps
   ```
2. Verify the port mapping in your `docker-compose.yml`:
   ```yaml
   ports:
     - "5984:5984"
   ```
3. Ensure no other service is using port 5984 on your host.

## 3. Authentication Issues

**Symptom:** Receiving "401 Unauthorized" errors.

**Possible Solutions:**

1. Verify your admin credentials in the `.env` file.
2. Check if the admin user was created correctly:
   ```
   curl http://localhost:5984/_users
   ```
3. Recreate the container to apply new credentials:
   ```
   docker-compose down && docker-compose up -d
   ```

## 4. Performance Issues

**Symptom:** Slow response times or high resource usage.

**Possible Solutions:**

1. Check system resources:
   ```
   docker stats couchdb
   ```
2. Optimize CouchDB configuration (see PERFORMANCE_TUNING.md).
3. Consider scaling your setup or using a CouchDB cluster.

## 5. Data Persistence Problems

**Symptom:** Data loss after container restart.

**Possible Solutions:**

1. Ensure you're using a named volume or bind mount:
   ```yaml
   volumes:
     - couchdb_data:/opt/couchdb/data
   ```
2. Check if the volume was created:
   ```
   docker volume ls
   ```
3. Inspect the volume for any issues:
   ```
   docker volume inspect couchdb_data
   ```

## 6. Replication Failures

**Symptom:** Replication between nodes fails in a cluster setup.

**Possible Solutions:**

1. Verify network connectivity between nodes.
2. Check if all nodes have the same `erlang.cookie`:
   ```
   docker exec couchdb cat /opt/couchdb/etc/vm.args | grep cookie
   ```
3. Ensure all nodes are part of the same cluster:
   ```
   curl http://admin:password@localhost:5984/_membership
   ```

## 7. Update/Upgrade Issues

**Symptom:** Problems after updating CouchDB version.

**Possible Solutions:**

1. Check compatibility between your data and the new CouchDB version.
2. Ensure you've followed the upgrade steps in UPGRADING.md.
3. Consider rolling back to the previous version if issues persist.

## 8. SSL/TLS Configuration Problems

**Symptom:** Unable to connect via HTTPS or SSL errors.

**Possible Solutions:**

1. Verify your SSL certificate and key paths in `docker-compose.yml`.
2. Check CouchDB logs for SSL-related errors.
3. Ensure your SSL certificates are valid and not expired.

## General Troubleshooting Steps

1. Always check Docker and CouchDB logs for error messages.
2. Verify your configuration in `docker-compose.yml` and `.env` files.
3. Ensure your host system meets the requirements for running CouchDB.
4. For persistent issues, consider recreating the container with a fresh config.

If you're still facing issues after trying these solutions, consider seeking help from the CouchDB community or filing an issue in the project repository.
