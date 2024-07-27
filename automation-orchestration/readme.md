# Automation and Orchestration

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-Powered-blue.svg)](https://www.docker.com/)
[![Contributions Welcome](https://img.shields.io/badge/Contributions-Welcome-brightgreen.svg)](CONTRIBUTING.md)

Welcome to the Automation and Orchestration section of the docker-compose-cookbook! This directory contains Docker Compose configurations for setting up various automation and orchestration tools to streamline your workflow and infrastructure management.

## 📋 Table of Contents

- [Available Setups](#-available-setups)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Usage](#-usage)
- [Security Considerations](#-security-considerations)
- [Contributing](#-contributing)
- [License](#-license)

## 🛠 Available Setups

| Tool | Description | Quick Start |
|------|-------------|-------------|
| [Ansible AWX](https://github.com/vintagedon/docker-compose-cookbook/tree/main/automation-orchestration/ansibleawx-postgres-redis) | Web UI for Ansible with PostgreSQL and Redis | [Quick Start](#ansible-awx) |
| [Rundeck](https://github.com/vintagedon/docker-compose-cookbook/tree/main/automation-orchestration/rundeck) | Job scheduler and runbook automation | [Quick Start](#rundeck) |
| [Stackstorm](https://github.com/vintagedon/docker-compose-cookbook/tree/main/automation-orchestration/stackstorm-mongodb-rabbitmq-postgres) | Event-driven automation platform | [Quick Start](#stackstorm) |

## 📋 Prerequisites

- Docker (version 20.10.0 or later)
- Docker Compose (version 1.29.0 or later)
- Git

## 💾 Installation

Clone the repository:

```bash
git clone https://github.com/vintagedon/docker-compose-cookbook.git
cd docker-compose-cookbook/automation-orchestration
```

## 🚀 Usage

### General Steps

1. Navigate to the desired tool's directory
2. Create and configure the `.env` file
3. Run Docker Compose

### Ansible AWX

```bash
cd ansibleawx-postgres-redis
cp .env.example .env
nano .env  # Edit settings as needed
docker-compose up -d
```

### Rundeck

```bash
cd rundeck
cp .env.example .env
nano .env  # Edit settings as needed
docker-compose up -d
```

### Stackstorm

```bash
cd stackstorm-mongodb-rabbitmq-postgres
cp .env.example .env
nano .env  # Edit settings as needed
docker-compose up -d
```

For detailed instructions, refer to the README in each tool's directory.

## 🔒 Security Considerations

- Keep Docker and all images updated
- Use strong, unique passwords
- Implement proper firewall rules
- Avoid unnecessary internet exposure
- Regular security audits
- Implement proper access controls
- Secure automation workflows
- Use encrypted connections (HTTPS, SSH)
- Carefully manage automation task permissions
- Implement secure secrets management

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/vintagedon/docker-compose-cookbook/blob/main/LICENSE) file for details.

---

⭐️ If you find this project useful, please consider giving it a star on GitHub! ⭐️
