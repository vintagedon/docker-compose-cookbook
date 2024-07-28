# Troubleshooting Guide for Wireguard Docker Setup

This document provides solutions to common issues you might encounter with your Wireguard Docker setup.

## Connection Issues

1. **Cannot Connect to Wireguard Server**

   - Ensure the Wireguard container is running: `docker ps`
   - Check if the correct port is exposed: `docker-compose ps`
   - Verify firewall rules allow traffic on the Wireguard port
   - Check server logs: `docker-compose logs wireguard`

2. **Client Can Connect but No Internet Access**

   - Verify the AllowedIPs setting in client config
   - Check if IP forwarding is enabled on the server: `sysctl net.ipv4.ip_forward`
   - Verify NAT rules on the server

3. **Intermittent Connection Drops**
   - Adjust PersistentKeepalive in peer configs (try 25 seconds)
   - Check for network congestion or packet loss
   - Verify MTU settings (see Performance Tuning guide)

## Configuration Issues

1. **Container Fails to Start**

   - Check Docker logs: `docker-compose logs wireguard`
   - Verify environment variables in `.env` file
   - Ensure the config directory has correct permissions

2. **Peer Configurations Not Generated**

   - Verify the PEERS variable in `.env` file
   - Check container logs for errors during peer generation
   - Ensure sufficient disk space for config generation

3. **Cannot Access Local Network Resources**
   - Verify AllowedIPs includes local network range
   - Check routing tables on server and client
   - Ensure local network allows traffic from Wireguard subnet

## Performance Issues

1. **Slow Connection Speeds**

   - Run speed tests with and without Wireguard to compare
   - Check CPU usage on server during transfers
   - Verify network speeds between client and server without Wireguard
   - Review Performance Tuning guide for optimization tips

2. **High Latency**
   - Check ping times with and without Wireguard
   - Verify server is not overloaded
   - Consider changing server location if consistently high latency

## Docker-specific Issues

1. **Container Restarts Repeatedly**

   - Check Docker logs for error messages
   - Verify host system has required kernel modules
   - Ensure Docker has necessary capabilities (NET_ADMIN, SYS_MODULE)

2. **Cannot Update Wireguard Image**
   - Ensure you have sufficient disk space
   - Try removing old images: `docker image prune`
   - Pull image manually: `docker pull linuxserver/wireguard:latest`

## Debugging Steps

1. **Enable Verbose Logging**:
   Add `LOG_CONFS=true` to your environment variables in `.env` file.

2. **Check Wireguard Status**:

   ```
   docker exec wireguard wg show
   ```

3. **Verify Routing**:
   On the server:

   ```
   ip route show table all
   ```

   On the client:

   ```
   ip route show
   ```

4. **Check for Kernel Module**:

   ```
   lsmod | grep wireguard
   ```

5. **Verify DNS Resolution**:
   ```
   docker exec wireguard cat /etc/resolv.conf
   ```

If you're still experiencing issues after trying these troubleshooting steps, consider seeking help on the Wireguard forums or Docker community channels. When asking for help, always provide relevant logs and configuration files (remember to remove sensitive information).
