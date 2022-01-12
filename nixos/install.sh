#! /bin/bash

set -e

function confirm2continue {
    echo -e "Are you sure you wish to continue?"
    read -p "Please type \"YES\": "
    if [ "$REPLY" != "YES" ]; then
        exit
    fi
}

# Some warnings!

echo -e "\nWARNING\n-------\nThis script will delete EVERYTHING and re-partition your hard drive!!"
confirm2continue

# Collect information

echo -e "\nINSTALLATION TARGET\n-------------------"
options=($(lsblk --paths --nodeps --output NAME --noheading))
PS3="Please select: "
select target in "${options[@]}"; do
    if [[ " ${options[*]} " =~ " ${target} " ]]; then
        echo "Usinig $target for installation"
	break
    fi
done

memory=$(($(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE) / (1024 * 1024 * 1024 ) + 1 ))

# What will be done?
echo -e "\nCONFIGURATION SUMMARY\n---------------------"

echo "Installation target: ${target}"
echo "RAM size: ${memory}"
echo "Partitions:"
echo -e "\tESP - from 1MiB to 512MiB (fat32)"
echo -e "\troot - from 512MiB to end (except ${memory}GiB)"
echo -e "\tswap - the last ${memory}GiB"

echo -e "\nReady to delete ALL your data on ${target}!"
confirm2continue

# Do it

# Wipe target device
echo -e "\nWipe ${target}"
echo "blkdiscard -v ${target}"
echo "wipefs -a ${target}"

# Partitioning
echo -e "\nCreating partitions"
echo "parted ${target} -- mklabel gpt"
echo "parted ${target} -- mkpart primary 512MiB -${memory}GiB"
echo "parted ${target} -- mkpart primary linux-swap -${memory}GiB 100%"
echo "parted ${target} -- mkpart ESP fat32 1MiB 512MiB"
echo "parted ${target} -- set 3 esp on"

# Format
echo -e "\nFormatting"
echo "mkfs.ext4 -L nixos ${target}1"
echo "mkswap -L swap ${target}2"
echo "mkfs.fat -F 32 -n boot ${target}3"

# Prepare installation
echo -e "\nPreparing installation"
echo "mount /dev/disk/by-label/nixos /mnt"
echo "mkdir -p /mnt/boot"
echo "mount /dev/disk/by-label/boot /mnt/boot"
echo "swapon ${target}2"

# Generate config
echo "nixos-generate-config --root /mnt"

