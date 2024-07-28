# Multi-Node Wireguard Setup Guide

This guide provides instructions for setting up a multi-node Wireguard network using Docker.

## Prerequisites

- Multiple servers with Docker and Docker Compose installed
- Basic understanding of networking and Wireguard concepts

## Architecture Overview

In this setup, we'll create a hub-and-spoke topology:

- One central server (hub) that all other nodes connect to
- Multiple edge nodes (spokes) that route traffic through the hub

```
       +-------+
       |  Hub  |
       +-------+
      /    |    \
     /     |     \
+-------+  |  +-------+
| Spoke1|  |  | Spoke2|
+-------+  |  +-------+
           |
        +-------+
        | Spoke3|
        +-------+
```

## Setup Instructions

### 1. Hub Node Setup

1. Choose one server to be the hub node.
2. Follow the standard setup instructions in the main README.md.
3. Modify the `.env` file:
   ```
   PEERS=3  # Adjust based on the number of spoke nodes
   ```
4. Start the Wireguard container:
   ```bash
   docker-compose up -d
   ```
5. Note down the hub's public key and IP address.

### 2. Spoke Node Setup

For each spoke node:

1. Clone this repository to the spoke server.
2. Modify the `docker-compose.yml`:
   ```yaml
   services:
     wireguard:
       # ... other configurations ...
       environment:
         - SERVERURL=<Hub_Public_IP>
         - SERVERPORT=<Hub_Wireguard_Port>
         - PEERDNS=auto
         - INTERNAL_SUBNET=10.13.13.0
         - ALLOWEDIPS=0.0.0.0/0
   ```
3. Create a `wg0.conf` file in the `config` directory:

   ```
   [Interface]
   PrivateKey = <Spoke_Private_Key>
   Address = 10.13.13.<X>/24  # X should be unique for each spoke

   [Peer]
   PublicKey = <Hub_Public_Key>
   Endpoint = <Hub_Public_IP>:<Hub_Wireguard_Port>
   AllowedIPs = 0.0.0.0/0
   PersistentKeepalive = 25
   ```

4. Start the Wireguard container:
   ```bash
   docker-compose up -d
   ```

### 3. Hub Configuration Update

1. On the hub node, edit the `wg0.conf` file in the `config` directory.
2. Add a peer section for each spoke:

   ```
   [Peer]
   PublicKey = <Spoke1_Public_Key>
   AllowedIPs = 10.13.13.<X>/32  # X matches the spoke's Address

   [Peer]
   PublicKey = <Spoke2_Public_Key>
   AllowedIPs = 10.13.13.<Y>/32  # Y is different from X

   # ... repeat for each spoke ...
   ```

3. Restart the hub's Wireguard container:
   ```bash
   docker-compose restart wireguard
   ```

## Routing Configuration

To enable communication between spokes:

1. On each spoke, add routes for other spokes via the hub:
   ```bash
   ip route add 10.13.13.0/24 via <Hub_Wireguard_IP>
   ```
2. Enable IP forwarding on the hub:
   ```bash
   echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
   sysctl -p
   ```

## Testing the Setup

1. From each spoke, try to ping other spokes and the hub:
   ```bash
   ping 10.13.13.1  # Hub
   ping 10.13.13.2  # Spoke1
   ping 10.13.13.3  # Spoke2
   # ... and so on
   ```
2. Test routing between spokes by running a simple HTTP server on one spoke and accessing it from another.

## Security Considerations

- Regularly update all nodes
- Use strong, unique keys for each node
- Implement firewall rules to restrict traffic between nodes as needed
- Monitor logs on all nodes for any suspicious activity

## Troubleshooting

- Check Wireguard logs on all nodes
- Verify routing tables and firewall rules
- Ensure all nodes have the correct time set
- Check for MTU mismatches between nodes

For more detailed troubleshooting, refer to the main [TROUBLESHOOTING.md](TROUBLESHOOTING.md) guide.

Remember to adjust IP addresses, ports, and other settings according to your specific network configuration. Always test thoroughly in a controlled environment before deploying to production.
