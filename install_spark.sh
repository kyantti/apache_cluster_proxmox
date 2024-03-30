#!/bin/bash

if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <spark_distribution.tgz> <container_id1> [<container_id2> ...]"
    exit 1
fi

master_id=0
master_ip=""
spark_tgz="$1"
spark_folder=$(basename "$spark_tgz" .tgz)

shift

for container_id in "$@"; do
    pct start "$container_id"
    pct exec  "$container_id" -- apt update
    pct exec  "$container_id" -- apt upgrade -y
    pct exec  "$container_id" -- apt install -y default-jre default-jdk python3 python3-pip
    pct push  "$container_id" -- "$spark_tgz" /opt/"$spark_tgz"
    pct exec  "$container_id" -- tar -xzvf "/opt/$spark_tgz" -C /opt/

    if [[ $container_id -gt $master_id ]]; then
        master_id="$container_id"
        master_ip=$(pct exec "$container_id" -- hostname -i)
        pct exec "$master_id" -- /opt/"$spark_folder"/sbin/start-master.sh -h 0.0.0.0
    else
        pct exec "$container_id" -- /opt/"$spark_folder"/sbin/start-worker.sh spark://"$master_ip":7077
    fi

done
