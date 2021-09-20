# setup




## prepare

```bash
# create key
ssh-keygen -t ed25519 -C "your_email@example.com"

# copy key
ssh-copy-id -i ~/.ssh/id_ed25519 user@host

# test connection
ansible -m setup -i host -u user
```

My personal Ansible playbook to install and configure my fedora installation.

```bash
# install and configure system
ansible-playbook playbook.yml -i hosts.ini  -u user --ask-become-pass
```

> **Note:** Change password of new user (default name: *earthling*)

```bash
ssh user@host
sudo passwd earthling
```

Add additional - work related - packages:

```bash
# needs to be executed as user earthling
ansible-playbook work-playbook.yml --ask-become-pass
```
