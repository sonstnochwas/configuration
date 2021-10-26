# elementary OS 6 (Odin)

## Assumptions

For the rest of the documentation we will assume, that user created during
base system instalation is named `marvin_tpa` and the user created by the
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
ssh-copy-id -i ~/.ssh/id_ed25519.pub marvin_tpa@TheNewOnesIPAddress

# test connection
ansible -m setup -i TheNewOnesIPAddress, -u marvin_tpa --ask-become-pass
```

### Continue with ...

[Ansible installation](ansible/README.md)

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



## Additional repositories

- [Mozilla VPN](https://support.mozilla.org/en-US/kb/how-install-mozilla-vpn-linux-computer)
- [Github CLI](https://github.com/cli/cli/blob/trunk/docs/install_linux.md#official-sources)
- [Docker CE](https://docs.docker.com/engine/install/ubuntu/)

## Rust

Reference: [here](https://www.rust-lang.org/tools/install)

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## kubectl

Reference: [here](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux)

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```

# helm

Reference: [here](https://helm.sh/docs/intro/install/#from-script)

```bash
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```
