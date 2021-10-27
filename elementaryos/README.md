# elementary OS 6 (Odin)

## Assumptions

For the rest of the documentation we will assume, that user created during
base system installation is named `automation` and the user created by the
playbook is called `earthling`.

The system (PC/Laptop) to be installed is referenced as `TheNewOne`, the Ansible
host is named `AnsibleHost`.

## Preparation

### `TheNewOne`: Install base system

There is no automation for installation of base system and there will probably never be one.

- [Download ISO](https://elementary.io/)
- [Create USB/DVD](https://elementary.io/docs/installation#creating-an-installation-medium)
- [Install](https://elementary.io/docs/installation#choose-operating-system)

> The user created during installation should not be named like the user
created with ansible, just because I haven't tested it, yet.

### `TheNewOne`: Install and start `sshd`

`sshd` is not included in default installation, so we need to add it:

```bash
# install
$ sudo apt install openssh-server
# (optional) check status
$ sudo systemctl status sshd
# You should see "Active: active(running)", otherwise start sshd:
$ sudo systemctl start sshd
```

You might want to remember the `TheNewOne`s IP address as `TheNewOnesIPAddress`:
```bash
$ hostname -I
```

### `AnsibleHost`: Create and copy ssh-key

```bash
# create key
ssh-keygen -t ed25519 -C "your_email@example.com"

# copy key
ssh-copy-id -i ~/.ssh/id_ed25519.pub automation@TheNewOnesIPAddress

# test connection
ansible all -m setup -i TheNewOnesIPAddress, -u automation --ask-become-pass
```

## Run Ansible playbooks

### Base system

```bash
# install and configure system
ansible-playbook base.yml -i TheNewOnesIPAddress, -u automation --ask-become-pass
```

> **Note:** Change password of new user (default name: *earthling*)

```bash
ssh automation@ip-address
sudo passwd earthling
```

### Additional tools for work

```bash
ansible-playbook work.yml -i TheNewOnesIPAddress, -u automation --ask-become-pass
```

## TODO: helm

Reference: [here](https://helm.sh/docs/intro/install/#from-script)

```bash
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```
