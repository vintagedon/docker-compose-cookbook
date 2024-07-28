#!/bin/bash
set -e

# Check if the OpenVPN configuration already exists
if [ -f "/etc/openvpn/openvpn.conf" ]; then
    echo "OpenVPN configuration already exists. Skipping initialization."
    exit 0
fi

# Generate OpenVPN configuration
ovpn_genconfig -u udp://${OVPN_SERVER_URL}

# Initialize the PKI
ovpn_initpki nopass

# Generate server configuration
ovpn_run &
OVPN_PID=$!

# Wait for the server to start
sleep 5

# Generate client configuration
if [ ! -z "${OVPN_CLIENT}" ]; then
    echo "Generating client configuration for ${OVPN_CLIENT}"
    easyrsa build-client-full ${OVPN_CLIENT} nopass
    ovpn_getclient ${OVPN_CLIENT} > /etc/openvpn/clients/${OVPN_CLIENT}.ovpn
fi

# Stop the temporary server
kill $OVPN_PID

echo "OpenVPN initialization complete."