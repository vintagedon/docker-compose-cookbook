# Ansible Playbooks and Roles

Ansible playbooks, roles, and other building blocks.

All playbooks based off of the default/recommended directory layout from the Ansible documentation.
Link: https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html#directory-layout

Directory structure can be created with the init optioin via ansible-galaxy

```
$ ansible-galaxy init --init-path=<path-to-roles-directory> <name-of-role>
$ ansible-galaxy init --init-path=playbooks/roles x
```

## Playbook Directory Structure

```
playbooks
└── roles
    └── x
        ├── README.md
        ├── defaults
        │   └── main.yml
        ├── files
        ├── handlers
        │   └── main.yml
        ├── meta
        │   └── main.yml
        ├── tasks
        │   └── main.yml
        ├── templates
        ├── tests
        │   ├── inventory
        │   └── test.yml
        └── vars
            └── main.yml
```
