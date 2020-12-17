#! /bin/sh

echo "\n === install required applications ==="
cd ~
apt update && apt upgrade -y

# install tzdata without user dialogue
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata

# install docker
apt install -y apt-transport-https curl ca-certificates gnupg-agent \
    software-properties-common && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" && \
apt update && \
apt install -y docker-ce docker-ce-cli containerd.io

# install newman
apt install -y nodejs npm && \
npm update && \
npm install -g newman && \
npm install -g newman-reporter-html

# clear
apt purge -y npm && \
apt install -f && \
apt autoremove -y