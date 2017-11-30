# create git repo
initial setup:
https://www.digitalocean.com/community/tutorials/how-to-set-up-a-private-git-server-on-a-vps

on server side run 'git init --bare my-project.git' to create empty repository
on client side run 'git remote set-url origin git@git.droplet.com:my-project.git' or 'git init && git remote add origin git@git.droplet.com:my-project.git' to set remote repository.

build with no cache:
docker build -t your-image --build-arg CACHEBUST=$(date +%s) .
