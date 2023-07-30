#!/bin/bash

# change into directory of script
pushd "$(dirname "$(readlink -f "$0")")"

# get token for dashboard access and make echos to easy copy of it
echo
multipass exec k3s -- kubectl get secret admin-user -n kube-system -o jsonpath={".data.token"} | base64 -d
echo
echo

# restore directory
popd
