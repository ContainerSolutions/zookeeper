#Zookeeper

This Docker image contains Zookeeper 3.5.0(-alpha?) which features dynamic host reconfiguration. Upon start, it attempts to join an existing cluster.

The syntax to start a container is like this:

  `docker run --name [name] containersol/zookeeper [id] [ip]`
  
where 
  - id = id of the zookeeper node (known internally as myid)
  - ip = ip address of a node of the existing cluster
  
The id is mandatory, the ip is optional.
