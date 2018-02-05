# Use an official Python runtime as a parent image
FROM initial-hadoop-setup
LABEL maintainer="esterlinkof@gmail.com"

USER root

ADD ./maven /root/.m2

RUN wget https://archive.apache.org/dist/hadoop/core/hadoop-2.7.1/hadoop-2.7.1-src.tar.gz && \
    tar xvzf hadoop-2.7.1-src.tar.gz --transform s/hadoop-2.7.1-src/my-hadoop/ && \
    cd /my-hadoop && \
    mvn package -Pdist -DskipTests -Dtar && \   
    ssh-keyscan 172.18.130.18  >> ~/.ssh/known_hosts && \
    cd /my-hadoop/hadoop-yarn-project/hadoop-yarn/hadoop-yarn-server && \
    rm -rf ./hadoop-yarn-server-resourcemanager && \
    git clone git@172.18.130.18:hadoop-yarn-server-resourcemanager.git hadoop-yarn-server-resourcemanager


# shouldn't cache these lines
ARG CACHEBUST=1
RUN cd /my-hadoop/hadoop-yarn-project/hadoop-yarn/hadoop-yarn-server/hadoop-yarn-server-resourcemanager && \
	git pull origin master && \
	mvn install -Pdist -DskipTests -Dtar && \
	cp ./target/hadoop-yarn-server-resourcemanager-2.7.1.jar /my-hadoop/hadoop-yarn-project/target/hadoop-yarn-project-2.7.1/share/hadoop/yarn/ && \
	cp ./target/hadoop-yarn-server-resourcemanager-2.7.1-sources.jar /my-hadoop/hadoop-yarn-project/target/hadoop-yarn-project-2.7.1/share/hadoop/yarn/sources/ && \
	cp ./target/hadoop-yarn-server-resourcemanager-2.7.1-test-sources.jar /my-hadoop/hadoop-yarn-project/target/hadoop-yarn-project-2.7.1/share/hadoop/yarn/sources/ && \
	mvn clean

# build project from dist directory
RUN cd /my-hadoop/hadoop-dist && \
	mvn install -Pdist -DskipTests -Dtar && \
	cp ./target/hadoop-2.7.1.tar.gz /usr/local/hadoop.tar.gz && \
	mvn clean && \
	cd /usr/local && \ 
	tar xzf hadoop.tar.gz && \
	rm hadoop.tar.gz && \
	mv hadoop-2.7.1 hadoop

# set up environment variables and conffig files
ARG RECONFIG=1
ENV HADOOP_HOME /usr/local/hadoop
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV HADOOP_CLASSPATH=/usr/lib/jvm/java-8-oracle/lib/tools.jar
RUN echo "# Some convenient aliases and functions for running Hadoop-related commands\nunalias fs &> /dev/null\nalias fs=\"hadoop fs\"\nunalias hls &> /dev/null\nalias hls=\"fs -ls\"" >> ~/.bashrc
ENV PATH="${PATH}:$HADOOP_HOME/bin"
COPY start.sh yarn-site.xml hadoop-env.sh hdfs-site.xml mapred-site.xml core-site.xml $HADOOP_HOME/etc/hadoop/
COPY WordCount.java mahdiz.big /home/

RUN mkdir -p /app/hadoop/tmp && \
	service ssh restart && \
	ssh-keyscan localhost  >> ~/.ssh/known_hosts && \
	ssh-keyscan 0.0.0.0  >> ~/.ssh/known_hosts && \
	hdfs namenode -format && \
	chmod +x $HADOOP_HOME/etc/hadoop/start.sh
	
WORKDIR /home/
#ENTRYPOINT $HADOOP_HOME/etc/hadoop/start.sh && /bin/bash
