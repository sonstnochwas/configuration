# elementary OS 6

## Additional packages

```bash
sudo apt install fish tmux tree tig git neovim curl firefox software-properties-common
```

## Mozilla VPN

Reference: [here](https://support.mozilla.org/en-US/kb/how-install-mozilla-vpn-linux-computer)

```bash
sudo add-apt-repository ppa:mozillacorp/mozillavpn
sudo apt-get update
sudo apt-get install mozillavpn
```

## Github CLI

Reference: [here](https://github.com/cli/cli/blob/trunk/docs/install_linux.md#official-sources)

```bash
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
```

## Docker CE

Reference: [here](https://docs.docker.com/engine/install/ubuntu/)

```bash
# add dependencies
sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

```bash
# add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

```bash
# add repository
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  focal stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

```bash
# install
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose
```

```bash
# add user to docker group
sudo groupadd docker
sudo usermod -aG docker $USER
```
