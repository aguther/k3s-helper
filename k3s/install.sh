#!/bin/bash

# change into directory of script
pushd "$(dirname "$(readlink -f "$0")")"

# create directory for images
mkdir -p /var/lib/rancher/k3s/agent/images/
# unpack images
gunzip ./k3s-airgap-images-amd64.tar.gz
# copy images
cp ./k3s-airgap-images-amd64.tar /var/lib/rancher/k3s/agent/images/

# make k3s executable
chmod +x ./k3s
# copy k3s binary
mv ./k3s /usr/local/bin/k3s

# make install script executable
chmod +x ./k3s-install.sh
# install and start k3s
INSTALL_K3S_SKIP_DOWNLOAD=true ./k3s-install.sh
# make config readable
chmod 644 /etc/rancher/k3s/k3s.yaml

# extract helm
tar xzf ./helm-v3.12.2-linux-amd64.tar.gz
# copy helm
mv ./linux-amd64/helm /usr/local/bin/helm
# clean up
rm -rf ./linux-amd64
# copy kubectl config for helm
mkdir -p /home/ubuntu/.kube
cp /etc/rancher/k3s/k3s.yaml /home/ubuntu/.kube/config
chown -R ubuntu:ubuntu /home/ubuntu/.kube
chmod 600 /home/ubuntu/.kube/config

# setup bash completion
echo "source <(kubectl completion bash)" > /home/ubuntu/.bash_aliases
echo "source <(helm completion bash)" >> /home/ubuntu/.bash_aliases
chown ubuntu:ubuntu /home/ubuntu/.bash_aliases

# restore directory
popd
