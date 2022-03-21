# create target directory
multipass exec k3s -- mkdir -p /tmp/skopeo

# transfer files
multipass transfer ./skopeo/containers-common_0.47.4-1_amd64.deb k3s:/tmp/skopeo/containers-common_0.47.4-1_amd64.deb
multipass transfer ./skopeo/cri-o-runc_1.1.0-1_amd64.deb k3s:/tmp/skopeo/cri-o-runc_1.1.0-1_amd64.deb
multipass transfer ./skopeo/skopeo_1.6.1-1_amd64.deb k3s:/tmp/skopeo/skopeo_1.6.1-1_amd64.deb

# install packages
multipass exec k3s -- sudo apt-get install /tmp/skopeo/cri-o-runc_1.1.0-1_amd64.deb /tmp/skopeo/containers-common_0.47.4-1_amd64.deb /tmp/skopeo/skopeo_1.6.1-1_amd64.deb

# delete temporary directory
multipass exec k3s -- rm -rf /tmp/skopeo
