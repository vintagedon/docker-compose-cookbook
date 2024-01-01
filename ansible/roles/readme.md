## Ansible Roles

A collection of re-usable Ansible roles that can be used either standalone or as building blocks for larger playbooks.

 # Usage

 Each role includes a ReadMe file, and comments where clarification is needed.

 # Role Directory Structure

 The init function from ansible-galaxy is used as a guide for all directory structures, including playbooks

 To initialize a blank role structure:

```
$ ansible-galaxy init rolename
```

The output is a directory structure like so:

```

 roles
 └── x
     ├── defaults
     ├── files
     ├── handlers
     ├── meta
     ├── tasks
     ├── templates
     ├── tests
     │    └── inventory
     └── vars
```
## Role Testing

These roles have only been tested with:

- Debian-base distributions
  - Ubuntu 22.04 LTS
  - Debian 12 Bookworm
- RHEL-based distributions
  - CentOS8 Stream
  - Alma Linux 
- Ansible versions
  - 2.15.x
