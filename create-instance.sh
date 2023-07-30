#!/bin/bash

# change into directory of script
pushd "$(dirname "$(readlink -f "$0")")"

# ensure virtual machine is fresh
multipass delete k3s
multipass purge

# create and start virtual machine
multipass launch --name k3s --cpus 2 --memory 2G --disk 5G

# restore directory
popd
