# Jenkins Docker Setup

This project contains a Docker Compose setup for Jenkins, including basic and advanced configuration options.

Jenkins is a popular open-source automation server that enables developers to build, test, and deploy their software projects continuously. It supports hundreds of plugins to integrate various development, testing, and deployment tools.

**Disclaimer:** This setup is based on general best practices and may not reflect the most current configuration options or requirements for Jenkins. Always refer to the [official Jenkins documentation](https://www.jenkins.io/doc/) for the most up-to-date and accurate information.

## GitHub Repository

https://github.com/vintagedon/docker-compose-cookbook/development-ci-cd/jenkins

## Prerequisites

- Docker
- Docker Compose
- At least 1 GB of RAM available for Jenkins
- 50 GB+ of free disk space

## Project Structure

```
.
├── docker-compose.yml
├── .env
└── README.md
```

## Files
- `docker-compose.yml`: Jenkins service configuration
- `.env`: Environment variables for Jenkins configuration
- `README.md`: Project information and instructions

## Usage

1. Edit the `.env` file with your desired configuration.
2. Run the container:

```bash
docker-compose up -d
```

3. Access Jenkins at `http://localhost:8080` (or the port you specified in the `.env` file).

4. Retrieve the initial admin password:

```bash
docker-compose exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

5. Use this password to complete the initial setup in the Jenkins web interface.

6. Check the logs to ensure Jenkins is running correctly:

```bash
docker-compose logs jenkins
```

You should see output similar to:

```
jenkins    | Running from: /usr/share/jenkins/jenkins.war
jenkins    | webroot: EnvVars.masterEnvVars.get("JENKINS_HOME")
jenkins    | 2023-07-27 12:34:56.789+0000 [id=1]     INFO    o.e.j.s.handler.ContextHandler#doStart: Started w.@12345678{Jenkins v2.xxx.x,/,file:///var/jenkins_home/war/,AVAILABLE}{/var/jenkins_home/war}
jenkins    | 2023-07-27 12:34:56.789+0000 [id=1]     INFO    o.e.j.server.AbstractConnector#doStart: Started ServerConnector@12345678{HTTP/1.1, (http/1.1)}{0.0.0.0:8080}
jenkins    | 2023-07-27 12:34:56.789+0000 [id=1]     INFO    org.eclipse.jetty.server.Server#doStart: Started @12345ms
jenkins    | 2023-07-27 12:34:56.789+0000 [id=22]    INFO    hudson.WebAppMain$3#run: Jenkins is fully up and running
```

## Expected Output

When Jenkins is running correctly, you should see:

1. The Jenkins web interface accessible at `http://localhost:8080` (or your specified port).
2. A prompt for the initial admin password when you first access the web interface.
3. Successful plugin installation and initial setup completion.
4. The Jenkins dashboard after logging in.
5. The output of `docker ps` should show the Jenkins container running. For example:

   ```
   $ docker ps
   CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS          PORTS                               NAMES
   abc123def456   jenkins/jenkins:lts   "/usr/bin/tini -- /u…"   10 minutes ago   Up 10 minutes   0.0.0.0:8080->8080/tcp, 50000/tcp   jenkins
   ```

## Configuration Options

### Basic Options

- `JENKINS_PORT`: The port on which Jenkins will be accessible (default: 8080)
- `JENKINS_HOME`: The directory where Jenkins stores its data (default: /var/jenkins_home)

### Common Options

- `JAVA_OPTS`: JVM options for Jenkins (e.g., memory settings)
- `JENKINS_OPTS`: Jenkins-specific options (e.g., custom war file location)

### Advanced Options

- `JENKINS_SLAVE_AGENT_PORT`: Port for Jenkins slave agent (default: 50000)
- `JENKINS_HTTPS_PORT`: Port for HTTPS access (requires additional setup)

Usage:

1. Uncomment relevant lines in the `.env` file.
2. Set desired values.
3. Restart the container:

```bash
docker-compose down && docker-compose up -d
```

## Data Persistence

Jenkins data is persisted in a Docker volume. This ensures that your configurations, jobs, and build history are preserved even if the container is removed or recreated.

## Networking

The Jenkins container is connected to a custom network named `jenkins_network`. This allows for easy communication between Jenkins and other services you might add in the future, such as build agents or databases.

## Security Note

1. Change the default admin password after initial setup.
2. Use Jenkins' built-in security features to manage user access and permissions.
3. Keep Jenkins and its plugins up to date to patch known vulnerabilities.
4. Consider setting up HTTPS for secure access, especially if exposed to the internet.
5. Be cautious when installing plugins, and only use trusted sources.

## Troubleshooting

Check logs: `docker-compose logs jenkins`

Common issues:

1. Permission issues: Ensure the `JENKINS_HOME` directory has the correct permissions (usually 1000:1000).
2. Memory issues: Increase the memory allocation in `JAVA_OPTS` if Jenkins is running slowly or crashing.
3. Plugin conflicts: If experiencing issues after installing new plugins, try disabling recently added plugins to isolate the problem.

For more detailed troubleshooting, please refer to the [official Jenkins documentation](https://www.jenkins.io/doc/book/troubleshooting/).

## Contributing

Feel free to submit issues, fork the repository and send pull requests!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
