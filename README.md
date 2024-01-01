# Infrastructure Scripts

Collection of scripts and resources centered around Docker, Kubernetes, Ansible and Infrastructure as Code.

Used primarily in my Home Lab https://github.com/vintagedon/proxmoxlab

# Docker Compose

Range of docker scirpts, including separate compose and .env files for changing / passing variables and secrets.

| Application | Description | Repository | 
| :------------------- | :---------------------------------- | :----------: |
| InfluxDB            | Time Series Database               | [REPO](https://github.com/vintagedon/infrastructure-scripting/tree/main/docker-compose/influxdb) |  
| Ngnix Proxy Manager | Reverse Proxy and SSL Cert Manager | [REPO](https://github.com/vintagedon/infrastructure-scripting/tree/main/docker-compose/nginx-proxy-manager-sqlite) |  
| SWAG                | Secure Web Application Gateway     | [REPO](https://github.com/vintagedon/infrastructure-scripting/tree/main/docker-compose/swag) |  
| WikiJS              | Modern and Extensible Wiki         | [REPO](https://github.com/vintagedon/infrastructure-scripting/tree/main/docker-compose/wikijs) |  

# Ansible Playbooks and Roles

Re-usable Ansible roles that can be used either standalone or as building blocks for larger playbooks.

## Ansible Roles

| Ansible Role | Description | Repository | 
| :---------------------------- | :---------------------------------- | :----------: |
| ansible-role-linux-update-apt | Upgrade via apt & reboot if necessary | [REPO](https://github.com/vintagedon/infrastructure-scripting/tree/main/ansible/roles) |
