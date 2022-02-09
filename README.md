# Configuration notes for various use cases

> These configurations are for my personal use and usually under construction ... so please use with care!

## Fedora 34 (`/fedora/`)

Here could be a extensive discussion about the GUI I prefer, but to be honest this is changing several times a year. I haven't used KDE Plasma in a wile so ... say "Hi!" to Fedora KDE spin :-)

After the base installation the user creation, software installation and KDE customization is done by Ansible.

By the way: KDE Plasma configuration seems to be straight forward with `ini`-files in `.config/`. There is an [Ansible module](https://docs.ansible.com/ansible/2.9/modules/ini_file_module.html) for that! Very handy!

## elementary OS (`/elementaryos/`)

In case KDE Plasma isn't my cup of tea ...

## NixOS

Moved to repository [sonstnochwas/nixos](../nixos/README.md)

## Distro-hopping relics

I'll use Fedora (i3wm and KDE spin) some time with my custom configuration ... which is about to be created.

## ToDo

Configuration | Description
--- | ---
`git config --global fetch.prune true` | Configure Git to automatically remove references to deleted remote branches when fetching.
