# Us. an official Python runtime as a parent image
FROM docker.kashipazha.ir/ubuntu:14.04
LABEL maintainer="esterlinkof@gmail.com"

USER root

# This line needed to remove this error : debconf: unable to initialize frontend: Dialog
#RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# install dev tools
RUN apt-get update && \
	apt-get install -y --no-install-recommends curl tar sudo openssh-server openssh-client rsync && \
    # update libselinux. see https://github.com/sequenceiq/hadoop-docker/issues/14
    apt-get install -y --no-install-recommends libselinux1-dev && \
    # passwordless ssh
    rm -f /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
    rm -f /etc/ssh/ssh_host_rsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    rm -f /root/.ssh/id_rsa | ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa && \
    cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys && \
    # java repository setup
    apt-get update && \
        apt-get install -y --no-install-recommends software-properties-common debconf-utils && \
        add-apt-repository ppa:webupd8team/java -y && \
        apt-get update && \
    # accept Oracle licence
    echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
    apt-get install -y --no-install-recommends oracle-java8-installer ; \
    # manually change to java 8u161
    cd /var/lib/dpkg/info && \
        sed -i 's|JAVA_VERSION=8u151|JAVA_VERSION=8u161|' oracle-java8-installer.* && \
        sed -i 's|PARTNER_URL=http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/|PARTNER_URL=http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/|' oracle-java8-installer.* && \
        sed -i 's|SHA256SUM_TGZ="c78200ce409367b296ec39be4427f020e2c585470c4eed01021feada576f027f"|SHA256SUM_TGZ="6dbc56a0e3310b69e91bb64db63a485bd7b6a8083f08e48047276380a0e2021e"|' oracle-java8-installer.* && \
        sed -i 's|J_DIR=jdk1.8.0_151|J_DIR=jdk1.8.0_161|' oracle-java8-installer.* && \
    # install java
	apt-get install -y --no-install-recommends oracle-java8-installer && \
        apt-get clean && \
	    rm -rf /var/lib/apt/lists/* && \
	    [ -f /var/cache/oracle-jdk8-installer ] && rm -rf /var/cache/oracle-jdk8-installer || echo "/var/cache/oracle-jdk8-installer was removed." && \
    # test java
    java -version && \
    # install maven
    apt-get install --no-install-recommends software-properties-common && \
	    apt-add-repository universe && \
	    apt-get update && \
	    apt-get install -y --no-install-recommends maven && \
    # test maven
    mvn -version && \
    apt-get update && \
        apt-get -y install --no-install-recommends protobuf-compiler && \
    # test protoc
    protoc --version && \
    # install git
    apt-get update && \
        apt-get -y --no-install-recommends install git && \
    # install native libraries
    apt-get update && \
	    apt-get -y --no-install-recommends install build-essential autoconf automake libtool cmake zlib1g-dev pkg-config libssl-dev && \
    # remove cached packets
    rm -rf /var/lib/apt/lists/*
