# Multi-Node Setup for CouchDB Docker

This guide provides instructions for setting up a multi-node CouchDB cluster using Docker.

## Prerequisites

- Docker and Docker Compose installed on all nodes
- Nodes can communicate with each other over the network

## Steps to Set Up a Multi-Node Cluster

1. **Prepare the Environment**

   On each node, create a `.env` file with the following content:

   ```
   COUCHDB_USER=admin
   COUCHDB_PASSWORD=password
   COUCHDB_SECRET=your_secret_here
   COUCHDB_ERLANG_COOKIE=your_erlang_cookie_here
   ```

   Make sure to use the same values for `COUCHDB_SECRET` and `COUCHDB_ERLANG_COOKIE` across all nodes.

2. **Modify docker-compose.yml**

   Update your `docker-compose.yml` file to include the necessary settings for clustering:

   ```yaml
   version: "3.8"

   services:
     couchdb:
       image: couchdb:latest
       environment:
         - COUCHDB_USER=${COUCHDB_USER}
         - COUCHDB_PASSWORD=${COUCHDB_PASSWORD}
         - COUCHDB_SECRET=${COUCHDB_SECRET}
         - COUCHDB_ERLANG_COOKIE=${COUCHDB_ERLANG_COOKIE}
         - ERL_FLAGS=-setcookie ${COUCHDB_ERLANG_COOKIE} -name couchdb@${NODE_IP}
       ports:
         - "5984:5984"
         - "4369:4369"
         - "9100:9100"
       volumes:
         - ./data:/opt/couchdb/data
   ```

   Replace `${NODE_IP}` with the actual IP address of each node.

3. **Start CouchDB on Each Node**

   On each node, run:

   ```
   docker-compose up -d
   ```

4. **Set Up the Cluster**

   On the first node, initialize the cluster:

   ```
   curl -X POST -H "Content-Type: application/json" http://admin:password@localhost:5984/_cluster_setup -d '{"action": "enable_cluster", "bind_address":"0.0.0.0", "username": "admin", "password":"password", "node_count":"3"}'
   ```

   Then, add each subsequent node to the cluster:

   ```
   curl -X POST -H "Content-Type: application/json" http://admin:password@localhost:5984/_cluster_setup -d '{"action": "add_node", "host":"<node2_ip>", "port": 5984, "username": "admin", "password":"password"}'
   ```

   Repeat for each additional node.

5. **Finish Cluster Setup**

   After adding all nodes, complete the setup:

   ```
   curl -X POST -H "Content-Type: application/json" http://admin:password@localhost:5984/_cluster_setup -d '{"action": "finish_cluster"}'
   ```

6. **Verify Cluster Status**

   Check the cluster status:

   ```
   curl -X GET http://admin:password@localhost:5984/_membership
   ```

## Considerations for Production Use

- Use SSL/TLS for secure communication between nodes.
- Implement proper network security measures to protect the cluster.
- Consider using a load balancer in front of the CouchDB cluster.
- Regularly backup your data and test the restoration process.

For more detailed information on CouchDB clustering, refer to the [official CouchDB documentation](https://docs.couchdb.org/en/stable/setup/cluster.html).
