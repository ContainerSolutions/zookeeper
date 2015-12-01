#Zookeeper

This Docker image contains Zookeeper 3.5.1 which features dynamic host reconfiguration. Upon start, it attempts to join an existing cluster.

The syntax to start a container is like this:

  `docker run -p 2181:2181 -p 2888:2888 -p 3888:3888 --name [name] containersol/zookeeper [ip]`
  
where 
  - `ip` = ip address of a node of the existing cluster
  
You don't need to supply `ip` for the first (or only) node in a cluster.

