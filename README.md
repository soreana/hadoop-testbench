# create git repo
initial setup:
https://www.digitalocean.com/community/tutorials/how-to-set-up-a-private-git-server-on-a-vps

on server side run 'git init --bare my-project.git' to create empty repository
on client side run 'git remote set-url origin git@git.droplet.com:my-project.git' or 'git init && git remote add origin git@git.droplet.com:my-project.git' to set remote repository.

build with no cache:
docker build -t hadoop --build-arg CACHEBUST=$(date +%s) .

## to run map-reduce test after build
    1. docker run -it hadoop
    2. cd /home/
    3. hadoop com.sun.tools.javac.Main WordCount.java
    4. jar cf wc.jar WordCount*.class
    5. hadoop jar wc.jar WordCount /user/sina/data /user/sina/output 

## start in multi user mode
    1. build in same way
    2. docker run -it -e HADOOP_HOSTS="10.0.0.1 master,10.0.0.2 slave1,10.0.0.3 slave2" -e MY_ROLE="master" hadoop
`HADOOP_HOSTS` shows clusters machines (default = "127.0.0.1 master") and `MY_ROLE` shows machines role in cluster that could be master,slave (default for multi node) or master-slave (default for single mode). Based on number of machines in HADOOP_HOSTS container whould run in single mode or multi node.

## setup network
    1. create network : docker network create --subnet=172.18.0.0/16 hadoop-cluster
    2. attach to network : docker run --net hadoop-cluster --ip 172.18.0.22 -it ubuntu bash
