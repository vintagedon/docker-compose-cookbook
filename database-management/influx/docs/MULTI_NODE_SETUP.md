# Multi-Node InfluxDB Setup Guide

This guide provides instructions for setting up a multi-node InfluxDB cluster using Docker Compose. Please note that this is an advanced configuration and should be used with caution in production environments.

## Prerequisites

- Docker Engine 20.10.0 or later
- Docker Compose 1.29.0 or later
- Understanding of InfluxDB clustering concepts

## Architecture Overview

In this setup, we'll create a cluster with three InfluxDB nodes:

1. A meta node that manages the cluster metadata
2. Two data nodes that store the actual time series data

## Configuration

1. Create a new `docker-compose.multi-node.yml` file with the following content:

```yaml
version: "3.8"

services:
  influxdb-meta:
    image: influxdb:${INFLUXDB_VERSION:-2.7}
    container_name: influxdb-meta
    command: influxd-meta
    ports:
      - "8091:8091"
    volumes:
      - influxdb-meta:/var/lib/influxdb
    environment:
      - INFLUXDB_META_DIR=/var/lib/influxdb/meta

  influxdb-data-1:
    image: influxdb:${INFLUXDB_VERSION:-2.7}
    container_name: influxdb-data-1
    ports:
      - "8086:8086"
    volumes:
      - influxdb-data-1:/var/lib/influxdb
    environment:
      - INFLUXDB_META_HOSTS=influxdb-meta:8091

  influxdb-data-2:
    image: influxdb:${INFLUXDB_VERSION:-2.7}
    container_name: influxdb-data-2
    ports:
      - "8087:8086"
    volumes:
      - influxdb-data-2:/var/lib/influxdb
    environment:
      - INFLUXDB_META_HOSTS=influxdb-meta:8091

volumes:
  influxdb-meta:
  influxdb-data-1:
  influxdb-data-2:

networks:
  default:
    name: influxdb_cluster_network
```

2. Update your `.env` file to include the following variables:

```
INFLUXDB_META_DIR=/var/lib/influxdb/meta
INFLUXDB_META_HOSTS=influxdb-meta:8091
```

## Starting the Cluster

1. Start the cluster using the new compose file:

```bash
docker-compose -f docker-compose.multi-node.yml up -d
```

2. Verify that all nodes are running:

```bash
docker-compose -f docker-compose.multi-node.yml ps
```

## Initializing the Cluster

1. Connect to one of the data nodes:

```bash
docker exec -it influxdb-data-1 bash
```

2. Run the InfluxDB setup command:

```bash
influx setup \
  --username admin \
  --password your-password \
  --org your-org \
  --bucket your-bucket \
  --force
```

3. Exit the container:

```bash
exit
```

## Verifying the Cluster

1. Use the InfluxDB CLI to check the cluster status:

```bash
docker exec -it influxdb-data-1 influx cluster status
```

You should see all three nodes listed in the output.

## Considerations and Limitations

- This setup is for demonstration purposes. For production use, you should implement proper security measures, including secure communication between nodes.
- Ensure that your Docker host has sufficient resources to run all three nodes.
- For production deployments, consider using a container orchestration system like Kubernetes for better management and scalability.

## Troubleshooting

If you encounter issues with the cluster setup:

1. Check the logs of each container:

```bash
docker-compose -f docker-compose.multi-node.yml logs
```

2. Ensure that all nodes can communicate with each other over the Docker network.

3. Verify that the meta node is accessible from the data nodes on port 8091.

For more detailed information on InfluxDB clustering, please refer to the [official InfluxDB documentation](https://docs.influxdata.com/influxdb/v2.7/reference/clustering/).
