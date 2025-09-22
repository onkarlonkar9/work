#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -xe

apt update -y
apt install -y docker.io

systemctl start docker
systemctl enable docker

sudo usermod -aG docker ubuntu

sleep 15

docker pull onkarlonkar9/strapi-prod
docker run -d -p 1337:1337 --restart always --name strapi_app onkarlonkar9/strapi-prod
