# Performance Tuning Guide for Wireguard Docker Setup

This document provides tips and strategies to optimize the performance of your Wireguard VPN setup.

## System-level Optimizations

1. **Increase Maximum File Descriptors**:
   Edit `/etc/security/limits.conf` and add:

   ```
   *       soft    nofile  51200
   *       hard    nofile  51200
   ```

   Then, restart your system.

2. **Optimize Network Stack**:
   Edit `/etc/sysctl.conf` and add:

   ```
   net.core.rmem_max = 67108864
   net.core.wmem_max = 67108864
   net.ipv4.tcp_rmem = 4096 87380 67108864
   net.ipv4.tcp_wmem = 4096 65536 67108864
   net.ipv4.tcp_mem = 65536 131072 262144
   net.ipv4.udp_mem = 65536 131072 262144
   ```

   Apply changes with `sysctl -p`.

3. **Enable BBR Congestion Control**:
   If your kernel supports it, enable BBR:
   ```
   echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
   echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
   sysctl -p
   ```

## Wireguard-specific Optimizations

1. **MTU Optimization**:
   Find the optimal MTU:

   ```
   ping -c 5 -M do -s 1500 [server_ip]
   ```

   Decrease the size until you get a response. Add 28 to this value and set it as your MTU in the Wireguard config.

2. **Adjust Keepalive Interval**:
   If you're experiencing connection drops, adjust the PersistentKeepalive option in peer configs. A value of 25 seconds is often a good balance.

3. **Use UDP Offloading**:
   If your network interface supports it, enable UDP offloading:
   ```
   ethtool -K [interface] tx-udp_tnl-segmentation on
   ```

## Docker-specific Optimizations

1. **Use Host Network Mode**:
   For better network performance, you can use host network mode. Update your `docker-compose.yml`:

   ```yaml
   services:
     wireguard:
       ...
       network_mode: host
   ```

   Note: This exposes the container directly to the host network, which may have security implications.

2. **Adjust Docker's Default Logging**:
   To reduce I/O, you can adjust Docker's logging. Create or edit `/etc/docker/daemon.json`:
   ```json
   {
     "log-driver": "json-file",
     "log-opts": {
       "max-size": "10m",
       "max-file": "3"
     }
   }
   ```
   Restart Docker after making changes.

## Monitoring Performance

1. **Use `wg show` for Basic Monitoring**:

   ```
   docker exec wireguard wg show
   ```

2. **Monitor Network Usage**:
   Use tools like `iftop` or `nethogs` to monitor network usage.

3. **Check System Resources**:
   Use `htop` to monitor CPU and memory usage.

Remember to test thoroughly after making any performance adjustments. Not all optimizations will benefit every setup, and some may even degrade performance in certain scenarios.
