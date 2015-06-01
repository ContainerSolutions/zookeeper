#!/bin/sh

MYID=$1
ZK=$2

HOSTNAME=`hostname`
IPADDRESS=`grep $HOSTNAME /etc/hosts | awk {'print $1'}`
cd /tmp/zookeeper

if [ -n "$ZK" ] 
then
  echo "`bin/zkCli.sh -server $ZK:2181 get /zookeeper/config|grep ^server`" >> /tmp/zookeeper/conf/zoo.cfg.dynamic
  echo "server.$MYID=$IPADDRESS:2888:3888:observer;2181" >> /tmp/zookeeper/conf/zoo.cfg.dynamic
  cp /tmp/zookeeper/conf/zoo.cfg.dynamic /tmp/zookeeper/conf/zoo.cfg.dynamic.org
  /tmp/zookeeper/bin/zkServer-initialize.sh --force --myid=$MYID
  ZOO_LOG_DIR=/var/log ZOO_LOG4J_PROP='INFO,CONSOLE,ROLLINGFILE' /tmp/zookeeper/bin/zkServer.sh start
  /tmp/zookeeper/bin/zkCli.sh -server $ZK:2181 reconfig -add "server.$MYID=$IPADDRESS:2888:3888:participant;2181"
  /tmp/zookeeper/bin/zkServer.sh stop
  ZOO_LOG_DIR=/var/log ZOO_LOG4J_PROP='INFO,CONSOLE,ROLLINGFILE' /tmp/zookeeper/bin/zkServer.sh start-foreground
  
else
  echo "server.$MYID=$IPADDRESS:2888:3888;2181" >> /tmp/zookeeper/conf/zoo.cfg.dynamic
  /tmp/zookeeper/bin/zkServer-initialize.sh --force --myid=$MYID
  ZOO_LOG_DIR=/var/log ZOO_LOG4J_PROP='INFO,CONSOLE,ROLLINGFILE' /tmp/zookeeper/bin/zkServer.sh start-foreground
fi

