# Security Guide for Neo4j Docker Setup

This document outlines key security considerations and best practices for your Neo4j Docker instance.

## Table of Contents

- [Security Guide for Neo4j Docker Setup](#security-guide-for-neo4j-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Authentication](#authentication)
  - [Network Security](#network-security)
  - [SSL/TLS Configuration](#ssltls-configuration)
  - [Role-Based Access Control](#role-based-access-control)
  - [Procedure Security](#procedure-security)
  - [Docker Security](#docker-security)
  - [Data Encryption](#data-encryption)

## Authentication

- Always change the default password immediately after first login.
- Use strong, unique passwords for all Neo4j users.
- Consider implementing multi-factor authentication for critical deployments.

Configuration:

```
NEO4J_AUTH=neo4j/<your-strong-password>
```

## Network Security

- Limit exposed ports to only those necessary.
- Use firewalls to restrict access to Neo4j ports.
- Consider using a reverse proxy for additional security layers.

## SSL/TLS Configuration

Enable SSL/TLS for all connections:

```
NEO4J_dbms_ssl_policy_bolt_enabled=true
NEO4J_dbms_ssl_policy_bolt_base__directory=/var/lib/neo4j/certificates
NEO4J_dbms_ssl_policy_bolt_private__key=private.key
NEO4J_dbms_ssl_policy_bolt_public__certificate=public.crt
```

Ensure certificates are properly managed and renewed.

## Role-Based Access Control

- Implement the principle of least privilege.
- Create specific roles for different access levels.
- Regularly audit user roles and permissions.

## Procedure Security

Restrict procedure execution to maintain security:

```
NEO4J_dbms_security_procedures_whitelist=apoc.coll.*,apoc.load.*
```

Be cautious when allowing unrestricted procedures:

```
NEO4J_dbms_security_procedures_unrestricted=apoc.*
```

## Docker Security

- Keep Docker and Neo4j images updated.
- Use non-root users inside containers.
- Implement resource limits to prevent DoS attacks.
- Use Docker secrets for sensitive information.

## Data Encryption

- Enable full database encryption for sensitive data:

```
NEO4J_dbms_encryption_level=REQUIRED
```

- Properly manage encryption keys.

Remember, security is an ongoing process. Regularly update your Neo4j instance, review security settings, and stay informed about the latest security best practices and vulnerabilities.

For more detailed security information, refer to the [official Neo4j security documentation](https://neo4j.com/docs/operations-manual/current/security/).
