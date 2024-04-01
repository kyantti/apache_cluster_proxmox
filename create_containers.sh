#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <num_ips>"
    exit 1
fi

# Define the number of free IPs to find
NUM_IPS="$1"

# Get the free IPs using nmap and reverse the order
FREE_IPS=$(sudo nmap -v -sn -n 192.168.1.0/24 -oG - | awk '/Status: Down/{print $2}' | tac)

# Exclude the .254 and .255 IP addresses
FREE_IPS=$(echo "$FREE_IPS" | grep -v "\.25[4|5]$")

# Select the first NUM_IPS free IPs
SELECTED_IPS=$(echo "$FREE_IPS" | head -n $NUM_IPS)

create_container() {
    local ip="$1"
    local host="$2"

    pct create "$host" /var/lib/vz/template/cache/ubuntu-22.04-standard_22.04-1_amd64.tar.zst \
        --arch amd64 \
        --ostype ubuntu \
        --hostname ubuntu-"$host" \
        --password="<pass>" \
        --storage local-lvm \
        --rootfs local-lvm:8 \
        --cores 1 \
        --memory 1024 \
        --swap 512 \
        --net0 name=eth0,bridge=vmbr0,firewall=1,ip="$ip"/24,gw=192.168.1.1 \
        --unprivileged 1 \
        --features nesting=1
}

for ip in $SELECTED_IPS; do
    host=$(echo "$ip" | awk -F'.' '{print $4}')
    create_container "$ip" "$host"

done

