#!/bin/bash

# set cluster's hosts IP
HADOOP_HOSTS="${HADOOP_HOSTS:-127.0.0.1 master}"
echo -e "\n#Hadoop hosts" >> /etc/hosts
echo "$HADOOP_HOSTS" | sed -e $'s/,/\\\n/g' >> /etc/hosts

# set my role
MY_ROLE="${MY_ROLE:-slave}"

# calculate host numbers
HOST_NUMBERS=`echo ${HADOOP_HOSTS} | tr -cd , | wc -c`
let "HOST_NUMBERS=HOST_NUMBERS+1"

if [ ${HOST_NUMBERS} -gt 1 ]
then
    # multi node initialization
    IS_SINGLE=false
else
    # single node initialization
    MY_ROLE="master-slave"
    IS_SINGLE=true
fi

echo ${HOST_NUMBERS}
echo ${IS_SINGLE}
echo ${MY_ROLE}

service ssh restart && \
    $HADOOP_HOME/sbin/start-dfs.sh && \
    $HADOOP_HOME/sbin/start-yarn.sh && \
    hdfs dfs -mkdir -p /user/sina/data && \
    hdfs dfs -copyFromLocal /home/mahdiz.big /user/sina/data
