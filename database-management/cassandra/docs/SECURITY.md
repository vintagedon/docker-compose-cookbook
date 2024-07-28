# Cassandra Security Guide

This document outlines security best practices for your Cassandra Docker setup.

## Authentication

By default, Cassandra uses `AllowAllAuthenticator`, which doesn't require authentication. For production environments, it's crucial to enable authentication:

1. Modify your `cassandra.yaml`:

   ```yaml
   authenticator: PasswordAuthenticator
   authorizer: CassandraAuthorizer
   ```

2. Restart your Cassandra container.

3. Create a superuser:

   ```sql
   CREATE USER admin WITH PASSWORD 'strong_password' SUPERUSER;
   ```

4. Disable the default 'cassandra' user:

   ```sql
   ALTER USER cassandra WITH PASSWORD 'random_password' NOSUPERUSER;
   ```

## Encryption

### SSL/TLS for Client-to-Node Encryption

1. Generate SSL certificates:

   ```bash
   keytool -genkey -keyalg RSA -alias node1 -keystore keystore.jks -storepass cassandra -keypass cassandra
   ```

2. Update `cassandra.yaml`:

   ```yaml
   client_encryption_options:
     enabled: true
     keystore: /etc/cassandra/keystore.jks
     keystore_password: cassandra
   ```

3. Mount the keystore in your Docker container:

   ```yaml
   volumes:
     - ./keystore.jks:/etc/cassandra/keystore.jks
   ```

### Node-to-Node Encryption

Update `cassandra.yaml`:

```yaml
server_encryption_options:
  internode_encryption: all
  keystore: /etc/cassandra/keystore.jks
  keystore_password: cassandra
  truststore: /etc/cassandra/truststore.jks
  truststore_password: cassandra
```

## Network Security

1. Use a private network for Cassandra nodes.
2. Use security groups or firewall rules to restrict access to Cassandra ports (7000, 7001, 7199, 9042).
3. Consider using a VPN for remote access.

## Data-at-Rest Encryption

Cassandra doesn't provide built-in data-at-rest encryption. Consider using disk-level encryption:

- For Docker volumes, use encrypted volumes.
- For host-mounted directories, use filesystem-level encryption like eCryptfs.

## Role-Based Access Control (RBAC)

Use CQL to manage roles and permissions:

```sql
CREATE ROLE readonly WITH PASSWORD = 'password' AND LOGIN = true;
GRANT SELECT ON keyspace_name.table_name TO readonly;
```

## Audit Logging

Enable audit logging to track database activities:

1. Add to `cassandra-env.sh`:

   ```bash
   JVM_OPTS="$JVM_OPTS -Dcassandra.audit_logging_options_enabled=true"
   ```

2. Configure in `cassandra.yaml`:

   ```yaml
   audit_logging_options:
     enabled: true
     logger:
       - class_name: BinAuditLogger
         parameters:
           - log_dir: /var/lib/cassandra/audit
           - roll_cycle: HOURLY
           - block: true
           - max_log_size: 1073741824
   ```

## Regular Updates

Keep your Cassandra version up-to-date to benefit from the latest security patches.

## Monitoring and Alerting

Set up monitoring and alerting for:

- Failed login attempts
- Unexpected schema changes
- Unusual query patterns
- Resource utilization spikes

## Security Scanning

Regularly scan your Docker images for vulnerabilities using tools like Trivy or Clair.

Remember, security is an ongoing process. Regularly review and update your security measures, and always follow the principle of least privilege.

For more detailed information, refer to the official Apache Cassandra security documentation.
