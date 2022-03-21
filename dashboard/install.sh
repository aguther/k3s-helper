#!/bin/bash

# change into directory of script
pushd "$(dirname "$(readlink -f "$0")")"

# unzip image(s)
gunzip /tmp/dashboard/image-dashboard.tar.gz
gunzip /tmp/dashboard/image-metrics-scraper.tar.gz

# load image(s)
ctr images import /tmp/dashboard/image-dashboard.tar
ctr images import /tmp/dashboard/image-metrics-scraper.tar

# install helm chart
helm install \
    kubernetes-dashboard \
    /tmp/dashboard/helm-kubernetes-dashboard.tgz \
    --kubeconfig=/etc/rancher/k3s/k3s.yaml \
    --namespace=kube-system \
    --atomic \
    --set metricsScraper.enabled=true

# deploy admin user
kubectl apply -f /tmp/dashboard/dashboard.admin-user-role.yml
kubectl apply -f /tmp/dashboard/dashboard.admin-user.yml

# patch service
kubectl patch service \
    kubernetes-dashboard \
    --namespace=kube-system \
    --type=json \
    --patch='[ { "op": "replace", "path": "/spec/ports/0/port", "value": 444 } ]'

kubectl patch service \
    kubernetes-dashboard \
    --namespace=kube-system \
    --type=json \
    --patch='[ { "op": "replace", "path": "/spec/type", "value": LoadBalancer } ]'

# restore directory
popd
