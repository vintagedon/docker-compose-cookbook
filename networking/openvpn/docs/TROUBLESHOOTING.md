# Troubleshooting Guide for OpenVPN Docker Setup

This document provides solutions to common issues you may encounter with your OpenVPN Docker setup.

## Table of Contents

1. [Connection Issues](#connection-issues)
2. [Performance Problems](#performance-problems)
3. [Certificate Errors](#certificate-errors)
4. [Docker-specific Issues](#docker-specific-issues)
5. [Logging and Debugging](#logging-and-debugging)

## Connection Issues

### Client can't connect to the server

1. Check if the OpenVPN container is running:

   ```
   docker-compose ps
   ```

2. Verify the server is listening on the correct port:

   ```
   docker-compose exec openvpn netstat -tulnp
   ```

3. Check firewall settings on the host machine:

   ```
   sudo iptables -L
   ```

4. Ensure the client configuration (.ovpn file) is correct:
   - Verify the server address and port
   - Check that the client certificate and key are properly embedded

### Connection drops frequently

1. Check network stability between client and server.
2. Adjust keepalive settings in server config:
   ```
   keepalive 10 60
   ```
3. Check for MTU issues:
   ```
   ping -M do -s 1500 <server_ip>
   ```
   Decrease MTU if needed:
   ```
   tun-mtu 1500
   mssfix 1450
   ```

## Performance Problems

### Slow connection speeds

1. Test server network speed:

   ```
   docker-compose exec openvpn speedtest-cli
   ```

2. Check CPU usage:

   ```
   docker stats openvpn
   ```

3. Try a different encryption cipher:

   ```
   cipher AES-256-GCM
   ```

4. Disable compression if enabled:
   ```
   comp-lzo no
   ```

## Certificate Errors

### "certificate is not yet valid" error

1. Check system time on both server and client:

   ```
   date
   ```

2. Sync time with NTP:
   ```
   sudo ntpdate pool.ntp.org
   ```

### "certificate has expired" error

1. Check certificate expiration:

   ```
   docker-compose exec openvpn openssl x509 -in /etc/openvpn/pki/issued/server.crt -noout -dates
   ```

2. Regenerate server and client certificates:
   ```
   docker-compose run --rm openvpn ovpn_getclient <clientname> > <clientname>.ovpn
   ```

## Docker-specific Issues

### Container fails to start

1. Check Docker logs:

   ```
   docker-compose logs openvpn
   ```

2. Verify Docker volume permissions:

   ```
   ls -l /path/to/openvpn/data
   ```

3. Ensure the container has the necessary capabilities:
   ```yaml
   cap_add:
     - NET_ADMIN
   ```

### Can't access container network

1. Check Docker network settings:

   ```
   docker network inspect openvpn_network
   ```

2. Ensure the container is connected to the correct network:
   ```yaml
   networks:
     - openvpn_network
   ```

## Logging and Debugging

### Enable verbose logging

1. Modify OpenVPN server config:

   ```
   verb 4
   ```

2. Restart the container:

   ```
   docker-compose restart openvpn
   ```

3. View logs:
   ```
   docker-compose logs -f openvpn
   ```

### Debug TLS handshake issues

Add to server config:

```
tls-debug 2
```

### Capture network traffic

1. Install tcpdump in the container:

   ```
   docker-compose exec openvpn apt-get update && apt-get install -y tcpdump
   ```

2. Capture traffic:

   ```
   docker-compose exec openvpn tcpdump -i eth0 udp port 1194 -w /tmp/openvpn.pcap
   ```

3. Copy capture file to host:
   ```
   docker cp openvpn:/tmp/openvpn.pcap .
   ```

Remember to revert any debugging changes once issues are resolved, as they may impact performance or security.

If you're still experiencing issues after trying these solutions, consider seeking help on the OpenVPN community forums or consulting with a networking professional.
