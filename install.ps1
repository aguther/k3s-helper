# create target directory
multipass exec k3s -- mkdir -p /tmp/k3s

# transfer files
multipass transfer ./k3s-files/k3s k3s:/tmp/k3s/k3s
multipass transfer ./k3s-files/k3s-airgap-images-amd64.tar.gz k3s:/tmp/k3s/k3s-airgap-images-amd64.tar.gz
multipass transfer ./k3s-files/deploy.sh k3s:/tmp/k3s/deploy.sh
multipass transfer ./k3s-files/k3s-install.sh k3s:/tmp/k3s/k3s-install.sh
multipass transfer ./k3s-files/helm-v3.8.1-linux-amd64.tar.gz k3s:/tmp/k3s/helm-v3.8.1-linux-amd64.tar.gz

# make script executable
multipass exec k3s -- sudo chmod +x /tmp/k3s/deploy.sh

# start deployment
multipass exec k3s -- sudo /tmp/k3s/deploy.sh

# delete temporary directory
multipass exec k3s -- rm -rf /tmp/k3s
