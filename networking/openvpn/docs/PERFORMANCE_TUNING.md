# Performance Tuning Guide for OpenVPN Docker Setup

This document provides guidance on optimizing the performance of your OpenVPN Docker setup.

## Table of Contents

- [Performance Tuning Guide for OpenVPN Docker Setup](#performance-tuning-guide-for-openvpn-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Server-side Optimizations](#server-side-optimizations)
  - [Client-side Optimizations](#client-side-optimizations)
  - [Network Optimizations](#network-optimizations)
  - [Hardware Considerations](#hardware-considerations)
  - [Monitoring and Benchmarking](#monitoring-and-benchmarking)

## Server-side Optimizations

1. **Use faster ciphers**: Consider using AES-256-GCM instead of AES-256-CBC. GCM mode is generally faster and provides authenticated encryption.

   ```
   cipher AES-256-GCM
   ```

2. **Optimize TLS settings**: Use TLS 1.2 or higher and optimize the cipher suite.

   ```
   tls-version-min 1.2
   tls-cipher TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384
   ```

3. **Adjust MTU and MSS**: Optimize these settings to reduce fragmentation.

   ```
   tun-mtu 1500
   mssfix 1450
   ```

4. **Enable multithreading**: If your server has multiple cores, enable multithreading.

   ```
   workers 4
   ```

5. **Use fast-io**: This can improve performance on some systems.

   ```
   fast-io
   ```

6. **Adjust keepalive settings**: This can help maintain connections through NAT.

   ```
   keepalive 10 120
   ```

## Client-side Optimizations

1. **Match server cipher**: Ensure clients use the same cipher as the server.

2. **Optimize compression**: If using compression, choose an efficient algorithm.

   ```
   compress lz4-v2
   ```

3. **Use UDP**: UDP is generally faster than TCP for VPN connections.

4. **Adjust MTU on clients**: Match the MTU settings with the server.

## Network Optimizations

1. **Use a fast DNS server**: Configure clients to use a fast, reliable DNS server.

2. **Optimize routing**: Ensure efficient routing between the VPN server and clients.

3. **Consider using TCP BBR**: If using TCP, enable BBR congestion control if available.

4. **Use Quality of Service (QoS)**: Implement QoS to prioritize VPN traffic.

## Hardware Considerations

1. **Use modern CPUs**: Modern CPUs with AES-NI support can significantly improve encryption performance.

2. **Provide sufficient RAM**: Ensure the server has enough RAM to handle the expected number of connections.

3. **Use SSDs**: Solid-state drives can improve I/O performance, especially for logging.

4. **Consider hardware acceleration**: Some network cards offer hardware acceleration for encryption.

## Monitoring and Benchmarking

1. **Use OpenVPN status**: Monitor the OpenVPN status file for real-time connection information.

2. **Implement server monitoring**: Use tools like Prometheus and Grafana to monitor server performance.

3. **Perform regular speed tests**: Conduct periodic speed tests to ensure optimal performance.

4. **Use iperf3**: Benchmark network performance using iperf3.

   ```bash
   # On the server
   docker-compose run --rm openvpn iperf3 -s

   # On the client
   iperf3 -c <vpn_server_ip>
   ```

Remember to test thoroughly after making any changes, as some optimizations may have trade-offs in terms of security or compatibility. Always prioritize security over performance when necessary.
