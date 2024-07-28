# MongoDB Multi-Node Setup Guide

This guide provides instructions for setting up a multi-node MongoDB deployment using Docker Compose. We'll cover both replica sets and sharded clusters.

## Replica Set Setup

A replica set in MongoDB is a group of mongod processes that maintain the same data set. Replica sets provide redundancy and high availability.

### 1. Modify docker-compose.yml

Update your `docker-compose.yml` to include multiple MongoDB instances:

```yaml
version: "3.8"

services:
  mongo1:
    image: mongo:${MONGO_VERSION:-5.0.9}
    container_name: mongo1
    command: mongod --replSet rs0 --bind_ip_all
    ports:
      - "27017:27017"
    volumes:
      - mongo1_data:/data/db

  mongo2:
    image: mongo:${MONGO_VERSION:-5.0.9}
    container_name: mongo2
    command: mongod --replSet rs0 --bind_ip_all
    ports:
      - "27018:27017"
    volumes:
      - mongo2_data:/data/db

  mongo3:
    image: mongo:${MONGO_VERSION:-5.0.9}
    container_name: mongo3
    command: mongod --replSet rs0 --bind_ip_all
    ports:
      - "27019:27017"
    volumes:
      - mongo3_data:/data/db

volumes:
  mongo1_data:
  mongo2_data:
  mongo3_data:
```

### 2. Initialize the Replica Set

After starting the containers with `docker-compose up -d`, initialize the replica set:

```bash
docker exec -it mongo1 mongosh --eval "
rs.initiate({
 _id: 'rs0',
 members: [
   {_id: 0, host: 'mongo1:27017'},
   {_id: 1, host: 'mongo2:27017'},
   {_id: 2, host: 'mongo3:27017'}
 ]
})
"
```

### 3. Verify Replica Set Status

Check the status of your replica set:

```bash
docker exec -it mongo1 mongosh --eval "rs.status()"
```

## Sharded Cluster Setup

A sharded cluster in MongoDB distributes data across multiple machines to support deployments with very large data sets and high throughput operations.

### 1. Modify docker-compose.yml for Sharded Cluster

Create a new `docker-compose.yml` for a sharded cluster:

```yaml
version: "3.8"

services:
  configsvr1:
    image: mongo:${MONGO_VERSION:-5.0.9}
    container_name: configsvr1
    command: mongod --configsvr --replSet configrs --port 27017
    volumes:
      - configsvr1:/data/db

  configsvr2:
    image: mongo:${MONGO_VERSION:-5.0.9}
    container_name: configsvr2
    command: mongod --configsvr --replSet configrs --port 27017
    volumes:
      - configsvr2:/data/db

  shard1svr1:
    image: mongo:${MONGO_VERSION:-5.0.9}
    container_name: shard1svr1
    command: mongod --shardsvr --replSet shard1rs --port 27017
    volumes:
      - shard1svr1:/data/db

  shard1svr2:
    image: mongo:${MONGO_VERSION:-5.0.9}
    container_name: shard1svr2
    command: mongod --shardsvr --replSet shard1rs --port 27017
    volumes:
      - shard1svr2:/data/db

  shard2svr1:
    image: mongo:${MONGO_VERSION:-5.0.9}
    container_name: shard2svr1
    command: mongod --shardsvr --replSet shard2rs --port 27017
    volumes:
      - shard2svr1:/data/db

  shard2svr2:
    image: mongo:${MONGO_VERSION:-5.0.9}
    container_name: shard2svr2
    command: mongod --shardsvr --replSet shard2rs --port 27017
    volumes:
      - shard2svr2:/data/db

  mongos:
    image: mongo:${MONGO_VERSION:-5.0.9}
    container_name: mongos
    command: mongos --configdb configrs/configsvr1:27017,configsvr2:27017 --bind_ip_all
    ports:
      - "27017:27017"
    depends_on:
      - configsvr1
      - configsvr2
      - shard1svr1
      - shard1svr2
      - shard2svr1
      - shard2svr2

volumes:
  configsvr1:
  configsvr2:
  shard1svr1:
  shard1svr2:
  shard2svr1:
  shard2svr2:
```

### 2. Initialize Config Servers and Shards

After starting the containers, initialize the config servers and shards:

```bash
# Initialize config server replica set
docker exec -it configsvr1 mongosh --port 27017 --eval "
rs.initiate({
 _id: 'configrs',
 members: [
   {_id: 0, host: 'configsvr1:27017'},
   {_id: 1, host: 'configsvr2:27017'}
 ]
})
"

# Initialize shard1 replica set
docker exec -it shard1svr1 mongosh --port 27017 --eval "
rs.initiate({
 _id: 'shard1rs',
 members: [
   {_id: 0, host: 'shard1svr1:27017'},
   {_id: 1, host: 'shard1svr2:27017'}
 ]
})
"

# Initialize shard2 replica set
docker exec -it shard2svr1 mongosh --port 27017 --eval "
rs.initiate({
 _id: 'shard2rs',
 members: [
   {_id: 0, host: 'shard2svr1:27017'},
   {_id: 1, host: 'shard2svr2:27017'}
 ]
})
"
```

### 3. Add Shards to the Cluster

Connect to the mongos router and add the shards:

```bash
docker exec -it mongos mongosh --port 27017 --eval "
sh.addShard('shard1rs/shard1svr1:27017,shard1svr2:27017');
sh.addShard('shard2rs/shard2svr1:27017,shard2svr2:27017');
"
```

### 4. Enable Sharding for a Database and Collection

To shard a specific database and collection:

```bash
docker exec -it mongos mongosh --port 27017 --eval "
sh.enableSharding('mydb');
sh.shardCollection('mydb.mycollection', { _id: 'hashed' });
"
```

## Connecting to Your Multi-Node Setup

- For the replica set, connect using the connection string: `mongodb://mongo1:27017,mongo2:27017,mongo3:27017/?replicaSet=rs0`
- For the sharded cluster, connect to the mongos router: `mongodb://mongos:27017`

Remember to replace hostnames with appropriate IP addresses or DNS names when connecting from outside the Docker network.

For more advanced configurations and management of your multi-node MongoDB setup, please refer to the [official MongoDB documentation](https://docs.mongodb.com/manual/tutorial/deploy-shard-cluster/).
