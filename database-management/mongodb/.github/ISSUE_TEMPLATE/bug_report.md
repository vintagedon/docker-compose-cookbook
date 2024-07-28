---
name: Bug report
about: Create a report to help us improve
title: "[BUG] "
labels: "bug"
assignees: ""
---

**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:

1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

**Expected behavior**
A clear and concise description of what you expected to happen.

**Screenshots**
If applicable, add screenshots to help explain your problem.

**Environment (please complete the following information):**

- OS: [e.g. Ubuntu 20.04]
- Docker version: [e.g. 20.10.7]
- Docker Compose version: [e.g. 1.29.2]
- MongoDB version: [e.g. 5.0.9]

**Docker Compose file**
Please provide your docker-compose.yml file (be sure to remove any sensitive information):

```yaml
version: "3.8"
services:
  mongodb:
    # Your configuration here
```

**Additional context**
Add any other context about the problem here. For example:

- Are you using a single instance, replica set, or sharded cluster?
- Have you made any modifications to the default configuration?
- Are you experiencing this issue in development or production?

**Logs**
Please provide relevant logs from your MongoDB container:

```
docker logs mongodb
```

**Additional Information**
Add any other information about the problem here. For example, have you tried any troubleshooting steps? If so, what were the results?
