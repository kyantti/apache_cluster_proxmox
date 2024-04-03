# Apache Cluster Proxmox

This repository contains a set of scripts designed to automate the creation of N containers on Proxmox VE and the setup of an Apache Spark cluster with N nodes.

## Features

- **create_containers.sh**: This script automates the process of creating N Ubuntu containers (the image can be replaced). It looks for N available contiguous IP addresses downstream and assigns each IP to a container, matching the container ID with the host part of the IP address.

    **Usage example**: `./create_containers.sh 3`

- **install_spark.sh**: This script automates the process of creating an Apache Spark cluster. It installs Apache Spark on each node and initializes the node with the highest ID as the master and the rest as workers.

    **Usage example**: `./install.sh spark-3.5.1-bin-hadoop3.tgz 252 251 250`

### Run Pi example

```bash
mkdir -p /home/Documents && /opt/spark-3.5.1-bin-hadoop3/bin/spark-submit --master spark://10.254.95.253:7077 pi.py > /home/Documents/spark_pi_example.txt
```
This command creates a `Documents` folder in the home directory if it doesn't exist, runs the Spark job, and stores the result in a file named `spark_pi_example.txt` inside `Documents`.

**Output**: `Pi is roughly 3.134280`

## Screenshots

![Screenshot](https://github.com/kyantti/apache_cluster_proxmox/assets/60965663/6aa9d1f8-e1fa-404d-a9e0-6174d8834369)
![Captura de Pantalla 2024-04-03 a las 17 31 45](https://github.com/kyantti/apache_cluster_proxmox/assets/60965663/9157b78e-f16c-4d76-8f72-3938a4c26449)


Feel free to explore the repository and use these scripts to simplify the setup and management of your Apache Spark clusters on Proxmox VE!
