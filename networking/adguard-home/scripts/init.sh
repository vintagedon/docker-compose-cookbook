#!/bin/bash

# This script initializes AdGuard Home with some basic configurations

# Wait for AdGuard Home to start
sleep 10

# Set up initial configuration
curl -X POST http://localhost:3000/control/dns_config \
  -H "Content-Type: application/json" \
  -d '{
    "upstream_dns": [
      "https://dns.cloudflare.com/dns-query",
      "https://dns.google/dns-query"
    ],
    "bootstrap_dns": [
      "1.1.1.1",
      "8.8.8.8"
    ],
    "filtering": {
      "enabled": true
    }
  }'

echo "Initial configuration completed."