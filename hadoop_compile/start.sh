#!/bin/bash

service ssh restart && $HADOOP_HOME/sbin/start-dfs.sh && $HADOOP_HOME/sbin/start-yarn.sh && hdfs dfs -mkdir -p /user/sina/data && hdfs dfs -copyFromLocal /home/mahdiz.big /user/sina/data
