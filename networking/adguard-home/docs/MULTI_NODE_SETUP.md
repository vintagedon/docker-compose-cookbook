# Multi-Node Setup for AdGuard Home

This guide provides instructions for setting up AdGuard Home in a multi-node configuration using Docker Swarm or Kubernetes.

## Docker Swarm Setup

1. Initialize a Docker Swarm:

   ```
   docker swarm init
   ```

2. Create a Docker Compose file for Swarm deployment (adguard-swarm.yml):

   ```yaml
   version: "3"
   services:
     adguardhome:
       image: adguard/adguardhome:latest
       ports:
         - "53:53/tcp"
         - "53:53/udp"
         - "3000:3000/tcp"
       volumes:
         - adguardhome_work:/opt/adguardhome/work
         - adguardhome_conf:/opt/adguardhome/conf
       deploy:
         replicas: 3
         update_config:
           parallelism: 1
           delay: 10s

   volumes:
     adguardhome_work:
     adguardhome_conf:
   ```

3. Deploy the stack:
   ```
   docker stack deploy -c adguard-swarm.yml adguardhome
   ```

## Kubernetes Setup

1. Create a Kubernetes deployment file (adguard-deployment.yaml):

   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: adguardhome
   spec:
     replicas: 3
     selector:
       matchLabels:
         app: adguardhome
     template:
       metadata:
         labels:
           app: adguardhome
       spec:
         containers:
           - name: adguardhome
             image: adguard/adguardhome:latest
             ports:
               - containerPort: 53
               - containerPort: 3000
             volumeMounts:
               - name: work
                 mountPath: /opt/adguardhome/work
               - name: conf
                 mountPath: /opt/adguardhome/conf
         volumes:
           - name: work
             emptyDir: {}
           - name: conf
             emptyDir: {}
   ```

2. Apply the deployment:

   ```
   kubectl apply -f adguard-deployment.yaml
   ```

3. Create a service to expose AdGuard Home (adguard-service.yaml):

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: adguardhome
   spec:
     selector:
       app: adguardhome
     ports:
       - name: dns-tcp
         port: 53
         targetPort: 53
         protocol: TCP
       - name: dns-udp
         port: 53
         targetPort: 53
         protocol: UDP
       - name: web
         port: 3000
         targetPort: 3000
   ```

4. Apply the service:
   ```
   kubectl apply -f adguard-service.yaml
   ```

## Considerations for Multi-Node Setup

1. Shared Configuration: Ensure all nodes share the same configuration. Consider using a shared filesystem or a configuration management tool.

2. Load Balancing: Set up a load balancer to distribute traffic across the nodes.

3. Synchronization: Implement a mechanism to synchronize block lists and custom rules across all nodes.

4. Monitoring: Use a centralized logging and monitoring solution to track the performance and health of all nodes.

5. Backup and Recovery: Implement a backup strategy for the shared configuration and data.

Remember to adjust firewall rules and network settings as necessary to allow traffic to your AdGuard Home cluster.
