# Performance Tuning for SoftEther VPN Docker Setup

This document provides guidance on optimizing the performance of your SoftEther VPN Docker setup.

## Hardware Considerations

1. **CPU**: SoftEther VPN is multi-threaded. Ensure your host has multiple CPU cores for better performance.
2. **RAM**: Allocate sufficient RAM to the Docker container. The amount needed depends on the number of concurrent users.
3. **Network Interface**: Use a high-speed network interface for better throughput.

## Docker Configuration

1. **Resource Limits**: Set appropriate CPU and memory limits in your `docker-compose.yml`:

   ```yaml
   services:
     softethervpn:
       # ... other configurations ...
       deploy:
         resources:
           limits:
             cpus: "2"
             memory: 2G
   ```

2. **Network Mode**: Consider using host network mode for better network performance:

   ```yaml
   services:
     softethervpn:
       # ... other configurations ...
       network_mode: host
   ```

## SoftEther VPN Configuration

1. **Optimize Buffer Size**: Adjust the send and receive buffer sizes:

   ```bash
   vpncmd localhost:5555 /SERVER /CMD NatSet /MTU:1500 /TCP_TIMEOUT:3600 /UDP_TIMEOUT:3600
   ```

2. **Adjust Keep Alive Settings**: Optimize keep-alive packet intervals:

   ```bash
   vpncmd localhost:5555 /SERVER /CMD KeepEnable /YES /KEEPALIVE:50 /INTERVAL:50
   ```

3. **Compression Settings**: Enable compression for better performance over slow links:

   ```bash
   vpncmd localhost:5555 /SERVER /CMD ServerCompressionSet /ENABLE:true
   ```

4. **Optimize Authentication**: Use lighter authentication methods for better performance.

5. **Limit Concurrent Connections**: Set a limit on concurrent connections to prevent overload:

   ```bash
   vpncmd localhost:5555 /SERVER /CMD ServerConfigSet /MaxConcurrent:100
   ```

## Monitoring and Tuning

1. **Enable Logging**: Enable detailed logging to monitor performance:

   ```bash
   vpncmd localhost:5555 /SERVER /CMD LogEnable /TYPE:ServerLog /SWITCH:true
   ```

2. **Regular Performance Checks**: Regularly check the server status and adjust settings as needed:

   ```bash
   vpncmd localhost:5555 /SERVER /CMD ServerStatusGet
   ```

3. **Traffic Monitoring**: Monitor network traffic to identify bottlenecks:

   ```bash
   vpncmd localhost:5555 /SERVER /CMD TrafficClient
   ```

Remember to test thoroughly after making any changes, as performance improvements can sometimes come at the cost of security or stability. Always balance performance with your security requirements.
