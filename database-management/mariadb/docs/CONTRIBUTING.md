# Contributing to MariaDB Docker Setup

We welcome contributions to the MariaDB Docker Setup project! This document provides guidelines for contributing to this repository.

## Table of Contents

- [Contributing to MariaDB Docker Setup](#contributing-to-mariadb-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Code of Conduct](#code-of-conduct)
  - [Getting Started](#getting-started)
  - [How to Contribute](#how-to-contribute)
  - [Pull Request Process](#pull-request-process)
  - [Style Guidelines](#style-guidelines)

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to [project_email@example.com].

## Getting Started

1. Fork the repository on GitHub.
2. Clone your fork locally.
3. Set up the development environment as described in the README.md file.

## How to Contribute

1. Check the issues page for open issues that you can work on.
2. If you have a new idea or found a bug, open a new issue to discuss it before making changes.
3. Make your changes in a new git branch:
   ```
   git checkout -b my-fix-branch main
   ```
4. Follow the [Style Guidelines](#style-guidelines).
5. Commit your changes using a descriptive commit message.
6. Push your branch to GitHub:
   ```
   git push origin my-fix-branch
   ```
7. Create a new Pull Request from your fork on GitHub.

## Pull Request Process

1. Ensure any install or build dependencies are removed before the end of the layer when doing a build.
2. Update the README.md with details of changes to the interface, this includes new environment variables, exposed ports, useful file locations and container parameters.
3. Increase the version numbers in any examples files and the README.md to the new version that this Pull Request would represent.
4. You may merge the Pull Request in once you have the sign-off of two other developers, or if you do not have permission to do that, you may request the second reviewer to merge it for you.

## Style Guidelines

1. Use meaningful and descriptive names for variables, functions, and classes.
2. Follow the existing code style and indentation.
3. Comment your code where necessary, especially for complex logic.
4. For Dockerfiles and docker-compose.yml files, follow the best practices as outlined in the Docker documentation.
5. For Markdown files, ensure proper formatting and use of headers, lists, and code blocks.

Thank you for contributing to the MariaDB Docker Setup project!
