# Multi-Node Cassandra Cluster Setup

This guide provides instructions for setting up a multi-node Cassandra cluster using Docker.

## Prerequisites

- Docker Engine 20.10.0 or later
- Docker Compose 1.29.0 or later
- Sufficient resources to run multiple Cassandra nodes (at least 4GB RAM per node)

## Configuration

1. Create a new `docker-compose.yml` file for the multi-node setup:

```yaml
version: "3.8"

services:
  cassandra-node1:
    image: cassandra:${CASSANDRA_VERSION:-latest}
    container_name: cassandra-node1
    ports:
      - "9042:9042"
    environment:
      - CASSANDRA_CLUSTER_NAME=MyCluster
      - CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch
      - CASSANDRA_DC=DC1
    volumes:
      - cassandra_data_1:/var/lib/cassandra

  cassandra-node2:
    image: cassandra:${CASSANDRA_VERSION:-latest}
    container_name: cassandra-node2
    ports:
      - "9043:9042"
    environment:
      - CASSANDRA_CLUSTER_NAME=MyCluster
      - CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch
      - CASSANDRA_DC=DC1
      - CASSANDRA_SEEDS=cassandra-node1
    volumes:
      - cassandra_data_2:/var/lib/cassandra
    depends_on:
      - cassandra-node1

  cassandra-node3:
    image: cassandra:${CASSANDRA_VERSION:-latest}
    container_name: cassandra-node3
    ports:
      - "9044:9042"
    environment:
      - CASSANDRA_CLUSTER_NAME=MyCluster
      - CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch
      - CASSANDRA_DC=DC1
      - CASSANDRA_SEEDS=cassandra-node1
    volumes:
      - cassandra_data_3:/var/lib/cassandra
    depends_on:
      - cassandra-node1

volumes:
  cassandra_data_1:
  cassandra_data_2:
  cassandra_data_3:

networks:
  default:
    name: cassandra_network
```

2. Start the cluster:

```
docker-compose up -d
```

3. Wait for all nodes to start. You can check the status using:

```
docker-compose logs -f
```

Wait until you see "Node /cassandra-nodeX is now part of the cluster" for all nodes.

## Verifying the Cluster

1. Connect to the first node:

```
docker exec -it cassandra-node1 cqlsh
```

2. Check the cluster status:

```sql
SELECT peer, host_id, schema_version FROM system.peers;
```

You should see entries for all nodes in the cluster.

3. You can also use nodetool to check the cluster status:

```
docker exec -it cassandra-node1 nodetool status
```

This should show all nodes as UN (Up/Normal) in the cluster.

## Adding More Nodes

To add more nodes to the cluster, simply add new services to the `docker-compose.yml` file following the pattern of `cassandra-node2` and `cassandra-node3`. Make sure to update the ports and container names accordingly.

## Removing Nodes

To remove a node from the cluster:

1. Stop the node:

```
docker-compose stop cassandra-nodeX
```

2. Run nodetool removenode on one of the remaining nodes:

```
docker exec -it cassandra-node1 nodetool removenode <host_id>
```

Replace `<host_id>` with the ID of the node you're removing (you can get this from the `system.peers` table).

3. Update your `docker-compose.yml` file to remove the node's service definition.

## Important Considerations

- Ensure that your firewall allows traffic on the necessary Cassandra ports (7000, 7001, 7199, 9042) between the nodes.
- For production environments, consider using separate physical machines or cloud instances for each node to improve fault tolerance.
- Adjust the `MAX_HEAP_SIZE` and `HEAP_NEWSIZE` environment variables based on your available resources and expected load.
- For cross-datacenter setups, make sure to adjust the `CASSANDRA_DC` environment variable accordingly.

Remember to consult the official Apache Cassandra documentation for best practices on cluster management and performance tuning in a multi-node setup.
