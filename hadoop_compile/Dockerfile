# Use an official Python runtime as a parent image
FROM initial-hadoop-setup
LABEL maintainer="esterlinkof@gmail.com"

USER root

ADD ./maven /root/.m2

RUN wget https://archive.apache.org/dist/hadoop/core/hadoop-2.7.1/hadoop-2.7.1-src.tar.gz
RUN tar xvzf hadoop-2.7.1-src.tar.gz --transform s/hadoop-2.7.1-src/my-hadoop/

# build all hadoop packages for first time
WORKDIR /my-hadoop
RUN mvn package -Pdist -DskipTests -Dtar

# import finger print of 172.18.130.25
RUN ssh-keyscan 172.18.130.25  >> ~/.ssh/known_hosts

# clone resourece manager for first time
WORKDIR /my-hadoop/hadoop-yarn-project/hadoop-yarn/hadoop-yarn-server
# remove old resource manager
RUN rm -rf ./hadoop-yarn-server-resourcemanager
# replace new one
#RUN git clone git@172.18.130.25:hadoop-yarn-server-resourcemanager.git hadoop-yarn-server-resourcemanager
#RUN ls 

# to do get scheduler form git
# shouldn't cache these lines

# ARG CACHEBUST=1
# RUN git pull origin master

# build project from dist directory

# setup hadoop directory
# RUN cp ./hadoop-dist/target/hadoop-2.7.1.tar.gz /usr/local/hadoop.tar.gz
# WORKDIR /usr/local
# RUN tar xzf hadoop.tar.gz 

# set up environment variables
# ENV HADOOP_HOME /usr/local/hadoop
# ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
# RUN echo "# Some convenient aliases and functions for running Hadoop-related commands\nunalias fs &> /dev/null\nalias fs=\"hadoop fs\"\nunalias hls &> /dev/null\nalias hls=\"fs -ls\"" >> ~/.bashrc
# ENV PATH="${PATH}:$HADOOP_HOME/bin"
# RUN echo $PATH
# RUN echo $JAVA_HOME




