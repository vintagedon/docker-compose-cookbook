# Influx DB Standalone

This Docker Compose provides a basic working stand-alone install of InfluxDB.

https://www.influxdata.com/

Notes: Used in my lab for dumping Proxmox metrics to; visualized w/Grafana.

# Project Structure

```
.
├── compose.yaml
└── README.md
```

# Deploy with Docker Compose

```
$ docker compose up -d

```

## Expected Result

Docker ps command must return one InfluxDB instance with the proper port configurations.

```
$ docker ps

```

## Web Interface

Go to ```http://INSTALLATION_IP_ADDRESS:8086``` to access the Influx DB login.

![2024-01-01 15_40_36-getting-started-wtih-influxdb-2-0-screenshot-1 png (1600×816)](https://github.com/vintagedon/infrastructure-scripting/assets/4473026/5d346863-74c7-4f6f-9f23-ba8b6a8b8e47)

# Remove with Docker Compose

```
$ docker compose down
```
