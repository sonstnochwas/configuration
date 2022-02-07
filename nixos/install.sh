#! /bin/bash

set -e

function confirm2continue {
    echo -e "Are you sure you wish to continue?"
    read -p "Please type \"YES\" -> "
    if [ "$REPLY" != "YES" ]; then
        exit
    fi
}

function getSwapSize {
    # based on https://itsfoss.com/swap-size
    local memory=$(($(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE) / (1024 * 1024 * 1024 ) + 1 ))
    echo $(echo "scale=0;$memory + sqrt($memory)" | bc)
}

# Some warnings!

echo -e "\nWARNING\n-------\nThis script will delete EVERYTHING and re-partition your hard drive!!"
confirm2continue

# Collect information

echo -e "\nINSTALLATION TARGET\n-------------------"
options=($(lsblk --paths --nodeps --output NAME --noheading))
PS3="Please select -> "
select target in "${options[@]}"; do
    if [[ " ${options[*]} " =~ " ${target} " ]]; then
        echo "Usinig $target for installation"
	break
    fi
done


# read password for disk encryption
echo -e "\nDISK ENCRYPTION PASSWORD\n-------------------"
while true; do
  read -s -p "Password         -> " password
  echo
  read -s -p "Password (again) -> " password2
  echo
  [ "$password" = "$password2" ] && break
  echo "Passwords don't match! Please try again."
done

# What will be done?
echo -e "\nCONFIGURATION SUMMARY\n---------------------"

swapSize=$(getSwapSize)
echo "Installation target: ${target}"
echo "SWAP size: ${swapSize} (for hibernation)"
echo "Partitions:"
echo -e "\tESP - from 1MiB to 512MiB (fat32)"
echo -e "\troot - from 512MiB to ${swapSize}GiB before the end"
echo -e "\tswap - the last ${swapSize}GiB"

echo -e "\nReady to delete ALL your data on ${target}!"
confirm2continue

# Do it

# Wipe target device
echo -e "\nWipe ${target}"
echo "blkdiscard -v ${target}"
echo "wipefs -a ${target}"

# Partitioning
# possible alternative sfdisk https://superuser.com/a/1132834
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

