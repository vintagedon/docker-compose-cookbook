#!/bin/bash

# This script initializes the SoftEther VPN server with custom settings

# Wait for the VPN server to start
sleep 10

# Set the server password
vpncmd localhost:5555 /SERVER /CMD ServerPasswordSet ${SERVER_PASSWORD}

# Create the default hub
vpncmd localhost:5555 /SERVER /CMD HubCreate DEFAULT /PASSWORD:${HUB_PASSWORD}

# Enable SecureNAT for the default hub
vpncmd localhost:5555 /SERVER /HUB:DEFAULT /CMD SecureNatEnable

# Set up IPsec/L2TP
vpncmd localhost:5555 /SERVER /CMD IPsecEnable /L2TP:yes /L2TPRAW:yes /ETHERIP:no /PSK:${IPSEC_PSK} /DEFAULTHUB:DEFAULT

# Set up OpenVPN
vpncmd localhost:5555 /SERVER /HUB:DEFAULT /CMD OpenVpnEnable yes /PORTS:1194

# Create users
IFS=',' read -ra USER_ARRAY <<< "$VPN_USERS"
for USER in "${USER_ARRAY[@]}"; do
    IFS=':' read -ra USER_PARTS <<< "$USER"
    USERNAME=${USER_PARTS[0]}
    PASSWORD=${USER_PARTS[1]}
    vpncmd localhost:5555 /SERVER /HUB:DEFAULT /CMD UserCreate ${USERNAME} /GROUP:none /REALNAME:none /NOTE:none
    vpncmd localhost:5555 /SERVER /HUB:DEFAULT /CMD UserPasswordSet ${USERNAME} /PASSWORD:${PASSWORD}
done

echo "SoftEther VPN server initialization complete."