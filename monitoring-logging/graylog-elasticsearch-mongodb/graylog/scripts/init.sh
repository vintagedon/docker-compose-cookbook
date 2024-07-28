#!/bin/bash

# Wait for Elasticsearch to be ready
echo "Waiting for Elasticsearch..."
while ! nc -z elasticsearch 9200; do
  sleep 1
done
echo "Elasticsearch is up"

# Wait for MongoDB to be ready
echo "Waiting for MongoDB..."
while ! nc -z mongodb 27017; do
  sleep 1
done
echo "MongoDB is up"

# Wait for Graylog to be ready
echo "Waiting for Graylog..."
while ! nc -z localhost 9000; do
  sleep 1
done
echo "Graylog is up"

# Add your initialization logic here
# For example, you can use the Graylog API to create inputs, streams

#!/bin/bash

# Wait for Elasticsearch to be ready
echo "Waiting for Elasticsearch..."
while ! nc -z elasticsearch 9200; do
  sleep 1
done
echo "Elasticsearch is up"

# Wait for MongoDB to be ready
echo "Waiting for MongoDB..."
while ! nc -z mongodb 27017; do
  sleep 1
done
echo "MongoDB is up"

# Wait for Graylog to be ready
echo "Waiting for Graylog..."
while ! nc -z localhost 9000; do
  sleep 1
done
echo "Graylog is up"

# Add your initialization logic here
# For example, you can use the Graylog API to create inputs, streams, etc.
# Create a GELF UDP input
curl -X POST -H "Content-Type: application/json" -H "X-Requested-By: cli" -u admin:admin -d '{
  "title": "GELF UDP",
  "type": "org.graylog2.inputs.gelf.udp.GELFUDPInput",
  "global": true,
  "configuration": {
    "bind_address": "0.0.0.0",
    "port": 12201
  }
}' http://localhost:9000/api/system/inputs

echo "Initialization complete"