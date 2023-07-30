#!/bin/bash

# change into directory of script
pushd "$(dirname "$(readlink -f "$0")")"

# get versions
source ./versions.sh

# create target directory
multipass exec k3s -- mkdir -p /tmp/dashboard

# transfer files
multipass transfer ./dashboard/install.sh k3s:/tmp/dashboard/install.sh
multipass transfer ./dashboard/dashboard.admin-user-role.yml k3s:/tmp/dashboard/dashboard.admin-user-role.yml
multipass transfer ./dashboard/dashboard.admin-user.yml k3s:/tmp/dashboard/dashboard.admin-user.yml
multipass transfer ./dashboard/dashboard.admin-user-secret.yml k3s:/tmp/dashboard/dashboard.admin-user-secret.yml
multipass transfer ./dashboard/helm-kubernetes-dashboard-${K8S_DASHBOARD_HELM_CHART_VERSION}.tgz k3s:/tmp/dashboard/helm-kubernetes-dashboard.tgz
multipass transfer ./dashboard/image-dashboard-v${K8S_DASHBOARD_IMAGE_VERSION}.tar.gz k3s:/tmp/dashboard/image-dashboard.tar.gz
multipass transfer ./dashboard/image-metrics-scraper-v${K8S_DASHBOARD_METRICS_SCRAPER_IMAGE_VERSION}.tar.gz k3s:/tmp/dashboard/image-metrics-scraper.tar.gz

# make script executable
multipass exec k3s -- sudo chmod +x /tmp/dashboard/install.sh

# start installation
multipass exec k3s -- sudo /tmp/dashboard/install.sh

# delete temporary directory
multipass exec k3s -- rm -rf /tmp/dashboard

# restore directory
popd
