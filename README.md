# Apache Cluster Proxmox

This repository contains a set of scripts designed to automate the creation of N containers on Proxmox VE and the setup of an Apache Spark cluster with N nodes.

## Features

- **create_containers.sh**: This script automates the process of creating N Ubuntu containers (the image can be replaced). It looks for N available contiguous IP addresses downstream and assigns each IP to a container, matching the container ID with the host part of the IP address.

    **Usage**: `./create_containers.sh 3`

- **install_spark.sh**: This script automates the process of creating an Apache Spark cluster. It installs Apache Spark on each node and initializes the node with the highest ID as the master and the rest as workers.

    **Usage**: `./install.sh spark-3.5.1-bin-hadoop3.tgz 252 251 250`

## Screenshots

![Screenshot](https://github.com/kyantti/apache_cluster_proxmox/assets/60965663/6aa9d1f8-e1fa-404d-a9e0-6174d8834369)

Feel free to explore the repository and use these scripts to simplify the setup and management of your Apache Spark clusters on Proxmox VE!
