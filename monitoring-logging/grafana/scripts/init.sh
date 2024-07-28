#!/bin/bash

# This script can be used to perform any initialization tasks for Grafana

# Example: Create a default data source
curl -X POST -H "Content-Type: application/json" -d '{
  "name":"Prometheus",
  "type":"prometheus",
  "url":"http://prometheus:9090",
  "access":"proxy",
  "isDefault":true
}' http://admin:admin@localhost:3000/api/datasources

# Example: Import a dashboard
curl -X POST -H "Content-Type: application/json" -d '{
  "dashboard": {
    "id": null,
    "title": "Default Dashboard",
    "tags": ["templated"],
    "timezone": "browser",
    "panels": [],
    "schemaVersion": 16,
    "version": 0
  },
  "overwrite": false
}' http://admin:admin@localhost:3000/api/dashboards/db

echo "Grafana initialization complete."