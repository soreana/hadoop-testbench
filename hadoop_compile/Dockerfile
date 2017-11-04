# Use an official Python runtime as a parent image
FROM initial-hadoop-setup
LABEL maintainer="esterlinkof@gmail.com"

USER root

ADD ./maven /root/.m2

RUN wget https://archive.apache.org/dist/hadoop/core/hadoop-2.7.1/hadoop-2.7.1-src.tar.gz
RUN tar xvzf hadoop-2.7.1-src.tar.gz

ARG CACHEBUST=1
RUN cd /hadoop-2.7.1-src && \
	mvn package -Pdist -DskipTests -Dtar
