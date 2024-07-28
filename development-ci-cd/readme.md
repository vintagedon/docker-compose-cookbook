# Development CI/CD

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-Powered-blue.svg)](https://www.docker.com/)
[![Contributions Welcome](https://img.shields.io/badge/Contributions-Welcome-brightgreen.svg)](CONTRIBUTING.md)

Welcome to the Development CI/CD section of the docker-compose-cookbook! This directory contains Docker Compose configurations for setting up various Continuous Integration and Continuous Deployment (CI/CD) tools to streamline your development workflow.

## 📋 Table of Contents

- [Development CI/CD](#development-cicd)
  - [📋 Table of Contents](#-table-of-contents)
  - [🛠 Available Setups](#-available-setups)
  - [📁 General Structure](#-general-structure)
  - [🚀 Usage](#-usage)
  - [🔒 Security Considerations](#-security-considerations)
  - [🤝 Contributing](#-contributing)
  - [📄 License](#-license)

## 🛠 Available Setups

| Tool               | Description                                         | Repo Link                                                                                                              |
| ------------------ | --------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| Gitea (MySQL)      | Self-hosted Git service with MySQL                  | [gitea-mysql](https://github.com/vintagedon/docker-compose-cookbook/tree/main/development-ci-cd/gitea-mysql)           |
| Gitea (PostgreSQL) | Self-hosted Git service with PostgreSQL             | [gitea-postgresql](https://github.com/vintagedon/docker-compose-cookbook/tree/main/development-ci-cd/gitea-postgresql) |
| Gitea (SQLite3)    | Self-hosted Git service with SQLite3                | [gitea-sqlite3](https://github.com/vintagedon/docker-compose-cookbook/tree/main/development-ci-cd/gitea-sqlite3)       |
| GitLab CE          | Self-hosted Git repository management               | [gitlabce](https://github.com/vintagedon/docker-compose-cookbook/tree/main/development-ci-cd/gitlabce)                 |
| Gogs (MySQL)       | Lightweight self-hosted Git service with MySQL      | [gogs-mysql](https://github.com/vintagedon/docker-compose-cookbook/tree/main/development-ci-cd/gogs-mysql)             |
| Gogs (Postgres)    | Lightweight self-hosted Git service with PostgreSQL | [gogs-postgres](https://github.com/vintagedon/docker-compose-cookbook/tree/main/development-ci-cd/gogs-postgres)       |
| Gogs (SQLite3)     | Lightweight self-hosted Git service with SQLite3    | [gogs-sqlite3](https://github.com/vintagedon/docker-compose-cookbook/tree/main/development-ci-cd/gogs-sqlite3)         |
| Jenkins (SQLite3)  | Automation server for CI/CD with SQLite3            | [jenkins-sqlite3](https://github.com/vintagedon/docker-compose-cookbook/tree/main/development-ci-cd/jenkins-sqlite3)   |

## 📁 General Structure

Each tool setup in this section typically follows this structure:

```
tool-name/
├── docker-compose.yml
├── .env.example
├── README.md
└── config/
    └── (tool-specific configuration files)
```

## 🚀 Usage

To use any of the CI/CD setups in this section:

1. Navigate to the desired tool's directory
2. Copy the `.env.example` file to `.env` and configure as needed
3. Run the Docker Compose command

For example, to set up Gitea with MySQL:

```bash
cd gitea-mysql
cp .env.example .env
nano .env  # Edit settings as needed
docker-compose up -d
```

Refer to each tool's README for specific instructions, configuration details, and access information.

## 🔒 Security Considerations

When working with CI/CD tools, keep these security practices in mind:

- Use strong, unique passwords for all services
- Implement proper firewall rules and network segmentation
- Regularly update Docker images and host systems
- Use HTTPS for web interfaces and encrypt communication between services
- Implement proper access controls and user management
- Regularly audit CI/CD pipelines and their permissions
- Use secure secret management practices for sensitive data in pipelines
- Implement network isolation between CI/CD environments and production
- Regularly back up configuration and data
- Monitor logs for suspicious activities

## 🤝 Contributing

We welcome contributions to improve and expand our development CI/CD setups! Here's how you can contribute:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

Please ensure your code follows the existing style and includes appropriate documentation.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/vintagedon/docker-compose-cookbook/blob/main/LICENSE) file for details.

---

⭐️ If you find this project useful, please consider giving it a star on GitHub! ⭐️
