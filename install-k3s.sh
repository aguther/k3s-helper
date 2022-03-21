#!/bin/bash

# change into directory of script
pushd "$(dirname "$(readlink -f "$0")")"

# get versions
source ./versions.sh

# create target directory
multipass exec k3s -- mkdir -p /tmp/k3s

# transfer files
multipass transfer ./k3s/k3s k3s:/tmp/k3s/k3s
multipass transfer ./k3s/k3s-airgap-images-amd64.tar.gz k3s:/tmp/k3s/k3s-airgap-images-amd64.tar.gz
multipass transfer ./k3s/install.sh k3s:/tmp/k3s/install.sh
multipass transfer ./k3s/k3s-install.sh k3s:/tmp/k3s/k3s-install.sh
multipass transfer ./k3s/helm-v${HELM_VERSION}-linux-amd64.tar.gz k3s:/tmp/k3s/helm-v${HELM_VERSION}-linux-amd64.tar.gz

# make script executable
multipass exec k3s -- sudo chmod +x /tmp/k3s/install.sh

# start installation
multipass exec k3s -- sudo /tmp/k3s/install.sh

# delete temporary directory
multipass exec k3s -- rm -rf /tmp/k3s

# restore directory
popd
