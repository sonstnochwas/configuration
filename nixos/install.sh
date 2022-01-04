#! /bin/sh

# System diagnosis

set -e

echo -e "System:\n------------"

MEMORY=$(($(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE) / (1024 * 1024 * 1024 ) + 1 ))
echo "Memory size: ${MEMORY}"

BLOCKDEVICES=$(lsblk --paths --nodeps --output NAME,SIZE,RO,MODEL)
echo -e "Block devices:\n${BLOCKDEVICES}"
