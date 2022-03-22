#!/bin/bash

# delete and purge instance
multipass delete test
multipass purge

# create instance with cloud init
multipass launch --name=test --cpus=1 --mem=1G --disk=5G --cloud-init=cloud-init.yaml

# get and print ip address
TEST_IP=$(multipass info test | grep IPv4 | awk '{print $2}' | xargs)
echo ${TEST_IP}

# wait
sleep 5

# ssh into test
ssh -oStrictHostKeyChecking=no user@${TEST_IP}
