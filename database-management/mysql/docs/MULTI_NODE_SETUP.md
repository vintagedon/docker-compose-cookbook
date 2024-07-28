# Multi-Node Setup for MySQL Docker

This document provides guidance on setting up a multi-node MySQL environment using Docker.

## Table of Contents

- [Multi-Node Setup for MySQL Docker](#multi-node-setup-for-mysql-docker)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Prerequisites](#prerequisites)
  - [Master Node Setup](#master-node-setup)
  - [Slave Node Setup](#slave-node-setup)
  - [Initializing Replication](#initializing-replication)
  - [Verifying Replication](#verifying-replication)
  - [Failover Considerations](#failover-considerations)

## Overview

A multi-node MySQL setup typically involves a master-slave replication configuration. The master node handles write operations, while slave nodes replicate data from the master and can handle read operations.

## Prerequisites

- Docker and Docker Compose installed on all nodes
- Network connectivity between nodes
- Unique `server-id` for each MySQL instance

## Master Node Setup

1. Modify your `docker-compose.yml` file on the master node:

```yaml
version: "3.8"
services:
  mysql-master:
    image: mysql:latest
    environment:
      - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
      - MYSQL_REPLICATION_USER=${MYSQL_REPLICATION_USER}
      - MYSQL_REPLICATION_PASSWORD=${MYSQL_REPLICATION_PASSWORD}
    volumes:
      - ./master.cnf:/etc/mysql/my.cnf
    ports:
      - "3306:3306"
```

2. Create a `master.cnf` file:

```ini
[mysqld]
server-id=1
log-bin=mysql-bin
binlog-format=ROW
```

## Slave Node Setup

1. Modify your `docker-compose.yml` file on the slave node:

```yaml
version: "3.8"
services:
  mysql-slave:
    image: mysql:latest
    environment:
      - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
    volumes:
      - ./slave.cnf:/etc/mysql/my.cnf
    ports:
      - "3306:3306"
```

2. Create a `slave.cnf` file:

```ini
[mysqld]
server-id=2
relay-log=relay-bin
read_only=1
```

## Initializing Replication

1. On the master node, create a replication user:

```sql
CREATE USER '${MYSQL_REPLICATION_USER}'@'%' IDENTIFIED BY '${MYSQL_REPLICATION_PASSWORD}';
GRANT REPLICATION SLAVE ON *.* TO '${MYSQL_REPLICATION_USER}'@'%';
FLUSH PRIVILEGES;
```

2. Get the master status:

```sql
SHOW MASTER STATUS;
```

3. On the slave node, set up replication:

```sql
CHANGE MASTER TO
  MASTER_HOST='<master_ip>',
  MASTER_USER='${MYSQL_REPLICATION_USER}',
  MASTER_PASSWORD='${MYSQL_REPLICATION_PASSWORD}',
  MASTER_LOG_FILE='<master_log_file>',
  MASTER_LOG_POS=<master_log_position>;

START SLAVE;
```

## Verifying Replication

On the slave node, check the replication status:

```sql
SHOW SLAVE STATUS\G
```

Look for `Slave_IO_Running: Yes` and `Slave_SQL_Running: Yes`.

## Failover Considerations

For high availability:

1. Implement a monitoring solution to detect master failure
2. Use a tool like MHA (MySQL High Availability) for automated failover
3. Consider using MySQL Group Replication for more advanced setups

Remember to adjust firewall rules and security groups to allow necessary traffic between nodes.
