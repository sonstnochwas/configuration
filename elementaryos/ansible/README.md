# Configure Fedora 34 KDE Spin

## Prepare

```bash
# create key
ssh-keygen -t ed25519 -C "your_email@example.com"

# copy key
ssh-copy-id -i ~/.ssh/id_ed25519.pub user-name@ip-address

# test connection
ansible -m setup -i ip-address, -u user-name --ask-become-pass
```

My personal Ansible playbook to install and configure my fedora installation.

```bash
# install and configure system
ansible-playbook base-playbook.yml -i ip-address, -u user-name --ask-become-pass
```

> **Note:** Change password of new user (default name: *earthling*)

```bash
ssh user-name@ip-address
sudo passwd earthling
```

Add additional - work related - packages:

```bash
# needs to be executed as user earthling
ansible-playbook work-playbook.yml --ask-become-pass
```
