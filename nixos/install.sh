#! /bin/bash

set -e

function shure {
    echo -e "\nAre you sure you wish to continue?"
    read -p "Please type \"YES\": "
    if [ "$REPLY" != "YES" ]; then
        exit
    fi
}

echo -e "NOTE:\nThis script will delete EVERYTHING and re-partition your hard drive!!"
shure

echo -e "\nINSTALLATION TARGET"

options=($(lsblk --paths --nodeps --output NAME --noheading))
PS3="Please select: "
select target in "${options[@]}"; do 
    if [[ " ${options[*]} " =~ " ${target} " ]]; then
        echo "Usinig $target for installation"
	break
    fi
done

echo -e "\n\nSystem:\n------------"

echo "Installation target: $target"

MEMORY=$(($(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE) / (1024 * 1024 * 1024 ) + 1 ))
echo "Memory size: ${MEMORY}"

BLOCKDEVICES=$(lsblk --paths --nodeps --output NAME,SIZE,RO,MODEL)
echo -e "Block devices:\n${BLOCKDEVICES}"
