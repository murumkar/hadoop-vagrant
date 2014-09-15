#!/bin/bash

. /etc/hadoop/conf/hadoop-env.sh

export HDFS_USER=hdfs
export YARN_USER=yarn
export HISTORY_SERVER_USER=mapred
export HADOOP_HOME=/usr/lib/hadoop
export HADOOP_CONF_DIR=/etc/hadoop/conf
export HADOOP_YARN_HOME=/usr/lib/hadoop-yarn
export MAPRED_HOME=/usr/lib/hadoop-mapreduce

# MR History Server
su - $HISTORY_SERVER_USER -c "export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec && $MAPRED_HOME/sbin/mr-jobhistory-daemon.sh stop historyserver --config $HADOOP_CONF_DIR"

# Execute Manually on all NodeManager nodes
for slave in $(cat $HADOOP_CONF_DIR/slaves); do
  # Execute Manually on all NodeManager nodes
  ssh $slave "export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec; su - $YARN_USER -c \"export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec && $HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR stop nodemanager\""
done

# YARN Resource Manager
su - $YARN_USER -c "export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec && $HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR stop resourcemanager"

# HDFS Data Node
for slave in $(cat $HADOOP_CONF_DIR/slaves); do
 ssh $slave "su - $HDFS_USER -c \"$HADOOP_HOME/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs stop datanode\"";
done

# HDFS Name Node
su - $HDFS_USER -c "$HADOOP_HOME/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs stop namenode"
