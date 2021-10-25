# elementary OS 6

## Preparation

### Install elementary OS 6

- Download iso
- create USB/DVD
- install *)

*) the user created during installation should not be named like the user created with ansible, because I have simply not tested it, yet.

### Install and start `sshd`

`sshd` is not included in default installation, so we need to add it:

```bash
# install
$ sudo apt install openssh-server
# (optional) check status
$ sudo systemctl start sshd
```

... should be `active` and `running` now.


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
