#!/bin/bash

# change into directory of script
pushd "$(dirname "$(readlink -f "$0")")"

# set version(s)
UBUNTU_VERSION=${1:-22.04}
source ./versions.sh

# clean and create output directory
rm -rf ./skopeo-${UBUNTU_VERSION}
mkdir -p ./skopeo-${UBUNTU_VERSION}

# download containers-common
${DOCKER_CMD} run \
    --rm \
    --env http_proxy=$http_proxy \
    --env https_proxy=$https_proxy \
    --volume $(pwd):/local \
    centos:latest \
    curl -L \
    https://download.opensuse.org/repositories/home:/alvistack/xUbuntu_${UBUNTU_VERSION}/amd64/containers-common_${CONTAINERS_COMMON_VERSION}_amd64.deb \
    -o /local/skopeo-${UBUNTU_VERSION}/containers-common_${CONTAINERS_COMMON_VERSION}_amd64.deb

# download cri-o-runc
${DOCKER_CMD} run \
    --rm \
    --env http_proxy=$http_proxy \
    --env https_proxy=$https_proxy \
    --volume $(pwd):/local \
    centos:latest \
    curl -L \
    https://download.opensuse.org/repositories/home:/alvistack/xUbuntu_${UBUNTU_VERSION}/amd64/cri-o-runc_${CRI_O_RUNC_VERSION}_amd64.deb \
    -o /local/skopeo-${UBUNTU_VERSION}/cri-o-runc_${CRI_O_RUNC_VERSION}_amd64.deb

# download skopeo
${DOCKER_CMD} run \
    --rm \
    --env http_proxy=$http_proxy \
    --env https_proxy=$https_proxy \
    --volume $(pwd):/local \
    centos:latest \
    curl -L \
    https://download.opensuse.org/repositories/home:/alvistack/xUbuntu_${UBUNTU_VERSION}/amd64/skopeo_${SKOPEO_VERSION}_amd64.deb \
    -o /local/skopeo-${UBUNTU_VERSION}/skopeo_${SKOPEO_VERSION}_amd64.deb

# restore directory
popd
