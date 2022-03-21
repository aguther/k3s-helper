#!/bin/bash

# change into directory of script
pushd "$(dirname "$(readlink -f "$0")")"

# get versions
source ./versions.sh

# delete current archives
rm -f ./k3s/k3s ./k3s/k3s-*.tar.gz helm-*.tar.gz

# download k3s
docker run \
    --rm \
    --env http_proxy=$http_proxy \
    --env https_proxy=$https_proxy \
    --volume $(pwd):/local \
    centos:latest \
    curl -L \
    https://github.com/k3s-io/k3s/releases/download/v${K3S_VERSION}%2Bk3s1/k3s \
    -o /local/k3s/k3s

# download k3s airgap images
docker run \
    --rm \
    --env http_proxy=$http_proxy \
    --env https_proxy=$https_proxy \
    --volume $(pwd):/local \
    centos:latest \
    curl -L \
    https://github.com/k3s-io/k3s/releases/download/v${K3S_VERSION}%2Bk3s1/k3s-airgap-images-amd64.tar.gz \
    -o /local/k3s/k3s-airgap-images-amd64.tar.gz

# download helm
docker run \
    --rm \
    --env http_proxy=$http_proxy \
    --env https_proxy=$https_proxy \
    --volume $(pwd):/local \
    centos:latest \
    curl -L \
    https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    -o /local/k3s/helm-v${HELM_VERSION}-linux-amd64.tar.gz

# restore directory
popd
