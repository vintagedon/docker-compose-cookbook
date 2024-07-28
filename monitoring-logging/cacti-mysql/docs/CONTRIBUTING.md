# Contributing to Cacti Docker Setup for Monitoring and Logging

We welcome contributions to improve this Docker setup for Cacti with MySQL, focusing on enhancing its monitoring and logging capabilities. Here are some guidelines to help you get started.

## Table of Contents

- [Contributing to Cacti Docker Setup for Monitoring and Logging](#contributing-to-cacti-docker-setup-for-monitoring-and-logging)
  - [Table of Contents](#table-of-contents)
  - [Code of Conduct](#code-of-conduct)
  - [How Can I Contribute?](#how-can-i-contribute)
    - [Reporting Bugs](#reporting-bugs)
    - [Suggesting Enhancements](#suggesting-enhancements)
    - [Pull Requests](#pull-requests)
  - [Style Guidelines](#style-guidelines)
    - [Git Commit Messages](#git-commit-messages)
    - [Docker and Compose Files](#docker-and-compose-files)
    - [Documentation](#documentation)
  - [Additional Notes](#additional-notes)
    - [Performance Considerations](#performance-considerations)
    - [Security](#security)

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to [project_email@example.com].

## How Can I Contribute?

### Reporting Bugs

- Use the issue tracker to report bugs
- Describe the exact steps to reproduce the problem
- Provide specific examples to demonstrate the steps
- Include details about your configuration and environment
- Specify the type of devices you're monitoring and any relevant logging settings

### Suggesting Enhancements

- Use the issue tracker to suggest enhancements
- Provide a clear and detailed explanation of the feature
- Include examples of how this enhancement would improve monitoring and logging capabilities
- Explain why this enhancement would be useful to most users

### Pull Requests

1. Fork the repo and create your branch from `main`.
2. If you've added code that should be tested, add tests.
3. If you've changed APIs, update the documentation.
4. Ensure the test suite passes.
5. Make sure your code lints.
6. Issue that pull request!

## Style Guidelines

### Git Commit Messages

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests liberally after the first line

### Docker and Compose Files

- Use 2 spaces for indentation
- Use lowercase for service names
- Use underscores for multi-word volume names

### Documentation

- Use Markdown for all documentation files
- Follow the existing structure for consistency

## Additional Notes

### Performance Considerations

When contributing, especially to areas that affect data collection or storage, consider the performance implications of your changes. Monitoring and logging can be resource-intensive, so optimizations are always welcome.

### Security

Given the sensitive nature of monitoring data, all contributions must adhere to security best practices. Any changes that could potentially expose monitoring data or weaken the system's security will be carefully reviewed.

Thank you for contributing to improve our Cacti Docker setup for monitoring and logging!
