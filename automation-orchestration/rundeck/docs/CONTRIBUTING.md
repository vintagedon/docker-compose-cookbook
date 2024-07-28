# Contributing to Rundeck Docker Setup

We welcome contributions to the Rundeck Docker Setup project! This document provides guidelines for contributing to this project.

## Code of Conduct

By participating in this project, you are expected to uphold our Code of Conduct. Please report unacceptable behavior to [project_email@example.com].

## How Can I Contribute?

### Reporting Bugs

- Ensure the bug was not already reported by searching on GitHub under [Issues](https://github.com/yourusername/rundeck-docker/issues).
- If you're unable to find an open issue addressing the problem, [open a new one](https://github.com/yourusername/rundeck-docker/issues/new). Be sure to include a title and clear description, as much relevant information as possible, and a code sample or an executable test case demonstrating the expected behavior that is not occurring.

### Suggesting Enhancements

- Open a new issue with a clear title and detailed description of the suggested enhancement.
- Provide any relevant examples or use cases that support your suggestion.

### Pull Requests

1. Fork the repo and create your branch from `main`.
2. If you've added code that should be tested, add tests.
3. If you've changed APIs, update the documentation.
4. Ensure the test suite passes.
5. Make sure your code lints.
6. Issue that pull request!

## Styleguides

### Git Commit Messages

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests liberally after the first line

### Dockerfile Styleguide

- Use official base images whenever possible
- Group related `RUN` instructions
- Use `COPY` instead of `ADD` for files and folders
- Specify explicit tags for base images

### Documentation Styleguide

- Use [Markdown](https://daringfireball.net/projects/markdown/) for documentation.
- Reference Rundeck and Docker version numbers where applicable.

## Additional Notes

### Issue and Pull Request Labels

This project uses labels to categorize issues and pull requests. Please use the following labels when creating an issue or pull request:

- `bug`: Something isn't working
- `enhancement`: New feature or request
- `documentation`: Improvements or additions to documentation
- `help-wanted`: Extra attention is needed
- `question`: Further information is requested

Thank you for contributing to Rundeck Docker Setup!
