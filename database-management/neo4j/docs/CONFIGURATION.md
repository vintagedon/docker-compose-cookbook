# Configuration Guide for Neo4j Docker Setup

This document provides detailed information on configuring your Neo4j Docker instance.

## Table of Contents

- [Configuration Guide for Neo4j Docker Setup](#configuration-guide-for-neo4j-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Environment Variables](#environment-variables)
  - [Neo4j Configuration](#neo4j-configuration)
  - [Memory Settings](#memory-settings)
  - [Network Configuration](#network-configuration)
  - [Security Settings](#security-settings)
  - [Plugin Management](#plugin-management)
  - [Logging](#logging)

## Environment Variables

The primary method of configuring the Neo4j Docker instance is through environment variables. These can be set in the `.env` file or passed directly to Docker Compose.

Key variables include:

- `NEO4J_AUTH`: Set the initial username/password. Default is `neo4j/neo4j`.
- `NEO4J_dbms_memory_heap_initial__size`: Initial heap size. Default is `512M`.
- `NEO4J_dbms_memory_heap_max__size`: Maximum heap size. Default is `2G`.
- `NEO4J_dbms_memory_pagecache_size`: Page cache size. Default is `512M`.

For a complete list of environment variables, refer to the `.env.example` file.

## Neo4j Configuration

Advanced Neo4j settings can be configured by adding environment variables with the `NEO4J_` prefix. For example:

```
NEO4J_dbms_security_procedures_unrestricted=apoc.*
```

This enables unrestricted APOC procedures.

## Memory Settings

Proper memory configuration is crucial for Neo4j performance. Key settings include:

- Heap memory: Set initial and max heap sizes.
- Page cache: Adjust based on the size of your graph and available system memory.

Example:

```
NEO4J_dbms_memory_heap_initial__size=1G
NEO4J_dbms_memory_heap_max__size=4G
NEO4J_dbms_memory_pagecache_size=4G
```

## Network Configuration

By default, Neo4j listens on the following ports:

- 7474: HTTP
- 7473: HTTPS
- 7687: Bolt

These can be modified in the `docker-compose.yml` file or via environment variables.

## Security Settings

Important security settings include:

- Authentication: Always change the default password.
- SSL/TLS: Configure SSL for secure communications.
- Procedure whitelisting: Restrict which procedures can be run.

Example SSL configuration:

```
NEO4J_dbms_ssl_policy_bolt_enabled=true
NEO4J_dbms_ssl_policy_bolt_base__directory=/var/lib/neo4j/certificates
NEO4J_dbms_ssl_policy_bolt_private__key=private.key
NEO4J_dbms_ssl_policy_bolt_public__certificate=public.crt
```

## Plugin Management

Plugins like APOC and GDS can be enabled with environment variables:

```
NEO4J_dbms_security_procedures_unrestricted=apoc.*,gds.*
NEO4J_apoc_import_file_enabled=true
NEO4J_gds_enterprise_license_file=/licenses/gds.license
```

Ensure the necessary plugin JAR files are mounted in the `/plugins` directory.

## Logging

Logging level can be adjusted with:

```
NEO4J_dbms_logs_debug_level=INFO
```

Valid levels are DEBUG, INFO, WARN, and ERROR.

For more detailed configuration options, always refer to the [official Neo4j documentation](https://neo4j.com/docs/).
