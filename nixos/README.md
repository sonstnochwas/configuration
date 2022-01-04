# NixOS 21.11

## Documentation

Detailed instructions: [official NixOS documentation](https://nixos.org/manual/nixos/stable/index.html)

## Pre-install

### Installation media

Download minimal ISO [here](https://channels.nixos.org/nixos-21.11/latest-nixos-minimal-x86_64-linux.iso) and write to thumb drive (recommendation: [Ventoy]{https://github.com/ventoy/Ventoy}).

### Set up wifi (w/o Network Manager)

Wifi interface name:
```bash
$ ip -br add
# or beautiful:
$ ip -brief -color address 
```

Start `wpa_supplicant`:
```bash
$ sudo systemctl start wpa_supplicant
```

Run `wpa_cli` to configure the wifi:
```bash
$ wpa_cli -i YourWifiInterfaceName
> add_network
0
> set_network 0 ssid "YourHomeNetwork"
OK
> set_network 0 psk "YourPassword"
OK
> set_network 0 key_mgmt WPA-PSK
OK
> enable_network 0
OK
... some more output ...
> quit
```

### Installation

[reference](https://gnulinux.ch/wie-installiert-man-nixos)

Notes:
```bash
pvcreate /dev/mapper/lvm
vgcreate main /dev/mapper/lvm
lvcreate -L 2G -n swap main
lvcreate -L 40G -n root main
lvcreate -l 100%FREE -n home main
```

## Try these services another time

- service.confluence
- services.dockerRegistry
- services.elasticsearch
- services.github-runner
- services.gitlab
- services.gocd-agent
- services.grafana
- services.haproxy
- services.jenkins
- services.jira
- services.journalbeat
- services.kibana
- services.kubernetes
- services.logstash
- services.loki
- services.minecraft-server
- services.nextcloud
- services.nginx
- services.nomad
- services.openldap
- services.postgresql
- services.prometheus
- services.rabbitmq
- services.redis
- services.redshift
- services.thermald
- services.thinkfan
- services.tlp
- services.vault
- services.vaultwarden
- services.xserver.desktopManager.wallpaper.mode
