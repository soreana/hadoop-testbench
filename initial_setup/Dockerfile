# Use an official Python runtime as a parent image
FROM docker.kashipazha.ir/pam-ubuntu-14.04
LABEL maintainer="esterlinkof@gmail.com"

USER root

# This line needed to remove this error : debconf: unable to initialize frontend: Dialog
#RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# install dev tools
RUN apt-get update && \
	apt-get install -y  curl tar sudo openssh-server openssh-client rsync
# update libselinux. see https://github.com/sequenceiq/hadoop-docker/issues/14
RUN apt-get install -y libselinux1-dev

# passwordless ssh
RUN rm -f /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN rm -f /etc/ssh/ssh_host_rsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN rm -f /root/.ssh/id_rsa | ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# java repository setup
RUN sudo apt-get install -y software-properties-common python-software-properties && \
	sudo add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" && \
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886

# accept Oracle licence
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# install java
RUN sudo apt-get update && \
	sudo apt-get install -y  oracle-java8-installer

# clean cache
RUN apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	[ -f /var/cache/oracle-jdk8-installer ] && rm -rf /var/cache/oracle-jdk8-installer || echo "/var/cache/oracle-jdk8-installer was removed."

# test java
RUN java -version

# install maven
RUN sudo apt-get install software-properties-common && \
	sudo apt-add-repository universe && \
	sudo apt-get update && \
	sudo apt-get install -y maven

# test maven
RUN mvn -version

# install protoc
RUN sudo apt-get update && \
        sudo apt-get -y install protobuf-compiler

# test protoc
RUN protoc --version
