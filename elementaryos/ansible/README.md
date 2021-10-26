# Configure elementary OS 6 (Odin)

## Prepare

```bash
# create key
ssh-keygen -t ed25519 -C "your_email@example.com"

# copy key
ssh-copy-id -i ~/.ssh/id_ed25519.pub marvin@ip-address

# test connection
ansible -m setup -i ip-address, -u user-name --ask-become-pass
```

My personal Ansible playbook to install and configure installation.

```bash
# install and configure system
ansible-playbook base-playbook.yml -i ip-address, -u marvin --ask-become-pass
```

> **Note:** Change password of new user (default name: *earthling*)

```bash
ssh marvin@ip-address
sudo passwd earthling
```

## WARNING: work in progress

Install additional packages for work:

```bash
ansible-playbook work-playbook.yml -i ip-address, -u marvin --ask-become-pass
```
