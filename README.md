# apache_cluster_proxmox
Set of scripts to automate the creation of N containers on Proxmox VE and the creation of an Apache Spark cluster with N nodes

The create_containers.sh script automates the procces of creating N ubuntu containers (the image can be replaced).The script looks for N available contiguous IP addresses downstream and assigns each IP to a container, matching the container id with the host part of the IP address.

The install_spark.sh script automates the process of creating an Apache Spark cluster.It installs Apache Spark on each node and initializes the node with the highest id as master and the rest as workers.

![Screenshot_20240330_225325](https://github.com/kyantti/apache_cluster_proxmox/assets/60965663/6aa9d1f8-e1fa-404d-a9e0-6174d8834369)

