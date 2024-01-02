## Ansible Role: Linux, Update via Apt

- Role: linux-server-apt.system-upgrade  
- Description: Performs an upgrade, and reboot, if necessary, for all Debian-based hosts using apt.

## Playbook Workflow

1. Update the APT cache
2. Check for updates
3. Upgrade all packages to latest version (dist)
4. Check for reboot required; if so, do the needful.
5. Wait for server to reboot; notify.

## Requirements
None.

## Role Variables
None.

## Dependencies
None.

## Example Playbook

```
- name Update Linux servers via apt
  remote_user: ubuntu # change to your remote user
  gather_facts: yes
  become: yes
  become_user: root
  become_method: sudo
  hosts: linuxservers-apt

  roles:
    - { role: linux-server-apt.system-upgrade }
```

