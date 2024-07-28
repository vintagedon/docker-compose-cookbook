# Troubleshooting SoftEther VPN Docker Setup

This document provides guidance on common issues and their solutions for the SoftEther VPN Docker setup.

## Connection Issues

1. **Unable to Connect to VPN Server**

   - Check if the container is running: `docker ps`
   - Verify port mappings: `docker port softethervpn`
   - Ensure firewall allows VPN ports
   - Check server logs: `docker logs softethervpn`

2. **Authentication Failures**

   - Verify user credentials in `.env` file
   - Check if users were created successfully in `init.sh`
   - Try resetting user password:
     ```bash
     docker exec softethervpn vpncmd localhost:5555 /SERVER /HUB:DEFAULT /CMD UserPasswordSet username /PASSWORD:newpassword
     ```

3. **Port Conflicts**
   - If you see "port is already allocated" error, change the host port in `docker-compose.yml`

## Performance Issues

1. **Slow Connection Speeds**

   - Check host system resources (CPU, RAM, Network)
   - Review `PERFORMANCE_TUNING.md` for optimization tips
   - Monitor server performance:
     ```bash
     docker exec softethervpn vpncmd localhost:5555 /SERVER /CMD ServerStatusGet
     ```

2. **High CPU Usage**
   - Check for any runaway processes inside the container:
     ```bash
     docker top softethervpn
     ```
   - Consider limiting CPU usage in `docker-compose.yml`

## Protocol-Specific Issues

1. **L2TP/IPsec Connection Problems**

   - Verify IPsec is enabled and configured correctly in `init.sh`
   - Check if UDP ports 500 and 4500 are open and mapped correctly

2. **OpenVPN Connection Issues**
   - Ensure OpenVPN is enabled in `init.sh`
   - Verify the OpenVPN port (default 1194) is open and mapped correctly

## Container Issues

1. **Container Fails to Start**

   - Check Docker logs: `docker logs softethervpn`
   - Verify all required environment variables are set in `.env`
   - Ensure `init.sh` has correct permissions and is executable

2. **Container Restarts Repeatedly**
   - Check for any error messages in the logs
   - Verify resource limits are set appropriately in `docker-compose.yml`

## Logging and Debugging

1. **Enable Debug Logging**

   ```bash
   docker exec softethervpn vpncmd localhost:5555 /SERVER /CMD LogEnable /TYPE:Debug /SWITCH:true
   ```

2. **View Real-time Logs**

   ```bash
   docker logs -f softethervpn
   ```

3. **Packet Capture for Advanced Debugging**
   ```bash
   docker exec softethervpn tcpdump -i any -w /opt/vpn_server/capture.pcap
   ```

If you encounter issues not covered here, consult the official SoftEther VPN documentation or seek support from the community forums.
