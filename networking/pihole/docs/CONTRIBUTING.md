# Contributing to Pi-hole Docker Setup

We appreciate your interest in contributing to the Pi-hole Docker project! This document provides guidelines for contributing to this repository.

## Table of Contents

- [Contributing to Pi-hole Docker Setup](#contributing-to-pi-hole-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Code of Conduct](#code-of-conduct)
  - [Getting Started](#getting-started)
  - [How to Contribute](#how-to-contribute)
  - [Pull Request Process](#pull-request-process)
  - [Style Guidelines](#style-guidelines)
  - [Community](#community)

## Code of Conduct

This project adheres to the Contributor Covenant [code of conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to [project_email@example.com].

## Getting Started

1. Fork the repository on GitHub.
2. Clone your fork locally.
3. Set up the development environment as described in the README.md.

## How to Contribute

1. **Reporting Bugs**:

   - Use the issue tracker to report bugs.
   - Describe the bug in detail, including steps to reproduce.
   - Include your environment details (OS, Docker version, etc.).

2. **Suggesting Enhancements**:

   - Use the issue tracker to suggest enhancements.
   - Clearly describe the enhancement and its expected behavior.

3. **Code Contributions**:
   - For significant changes, please open an issue first to discuss.
   - Make your changes in a new git branch.
   - Follow the [Style Guidelines](#style-guidelines).
   - Add or update relevant documentation.
   - Add appropriate tests for your changes.

## Pull Request Process

1. Ensure your code adheres to the [Style Guidelines](#style-guidelines).
2. Update the README.md with details of changes, if applicable.
3. Add your changes to the CHANGELOG.md in the "Unreleased" section.
4. Ensure all tests pass and the build is successful.
5. Submit a pull request to the `main` branch.
6. Your pull request will be reviewed by maintainers, who may request changes.
7. Once approved, your pull request will be merged.

## Style Guidelines

1. **Docker**:

   - Follow [Docker best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/).
   - Use official base images when possible.

2. **YAML**:

   - Use 2 spaces for indentation.
   - Keep lines under 80 characters when possible.

3. **Markdown**:

   - Use [GitHub Flavored Markdown](https://github.github.com/gfm/).
   - Use headers to organize content.
   - Use code blocks for commands and code snippets.

4. **Commit Messages**:
   - Use the present tense ("Add feature" not "Added feature").
   - Use the imperative mood ("Move cursor to..." not "Moves cursor to...").
   - Limit the first line to 72 characters or less.
   - Reference issues and pull requests liberally after the first line.

## Community

- Join the [Pi-hole Discourse](https://discourse.pi-hole.net/) for discussions.
- Follow [@pihole on Twitter](https://twitter.com/pihole) for updates.

Thank you for contributing to Pi-hole Docker!
