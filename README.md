## Docker Compose Cookbook

> A collection of Docker compose scripts centered around use in a home lab for learning IT technologies.

## Table of Contents

- [About](#about)
- [Features](#features)
- [How to Use](#how-to-use)
- [Contributing](#contributing)
- [License](#license)

## About 

This repository provides docker compose files, along with .env files, in a standardized format that provide a starting point for spinning up common services and applications in a cookbook type format.

NOTE: This collection is meant to be used in a home lab, non-critical development environment or for exploring technolgies. These compose files should never be used in a production environment without modification to fit your security needs.

## Features

- Comprehensive collection of Docker Compose files
- Utilizes .env files for easy configuration
- Focus on self-hosted technologies
- Designed for use in virtualization home labs
- Covers a wide range of IT and development technologies

## Categories

Our Docker Compose files are organized into the following categories:

- [Networking](./networking)
- [Monitoring & Logging](./monitoring-logging)
- [Automation & Orchestration](./automation-orchestration)
- [Development & CI/CD](./development-ci-cd)
- [Database Management](./database-management)
- [Storage Solutions](./storage-solutions)
- [Security](./security)
- [Container Management](./container-management)
- [Web & Application Servers](./web-application-servers)
- [Messaging & Collaboration](./messaging-collaboration)
- [Virtualization](./virtualization)
- [Home Automation](./home-automation)
- [Media & Entertainment](./media-entertainment)
- [Educational Tools](./educational-tools)
- [Miscellaneous](./miscellaneous)

## How to Use

Each Docker Compose file in this repository is accompanied by a corresponding .env file for configuration. To use any of the setups:

1. Navigate to the desired application's directory
1. Copy the .env.example file to .env
1. Modify the .env file with your specific configuration
1. Run docker-compose up -d to start the containers

**Clone the Repository**
    ```
    git clone https://github.com/vintagedon/docker-compose-cookbook
    ```
## Contributing

We welcome contributions! If you have a Docker Compose file for an application not yet included, please submit a pull request. For major changes, please open an issue first to discuss what you would like to change.

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

---

Thank you for using **[REPO_NAME]**! If you have any questions or need support, feel free to open an issue or contact the maintainers.
