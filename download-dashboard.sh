#!/bin/bash

# change into directory of script
pushd "$(dirname "$(readlink -f "$0")")"

# get versions
source ./versions.sh

# delete current archives
rm -f ./dashboard/helm* ./dashboard/image*

# download helm chart for dashboard
docker run \
    --rm \
    --env http_proxy=$http_proxy \
    --env https_proxy=$https_proxy \
    --volume $(pwd):/local \
    centos:latest \
    curl -L \
    https://kubernetes.github.io/dashboard/kubernetes-dashboard-${K8S_DASHBOARD_HELM_CHART_VERSION}.tgz \
    -o /local/dashboard/helm-kubernetes-dashboard-${K8S_DASHBOARD_HELM_CHART_VERSION}.tgz

# download kubernetes-dashboard image
docker run \
    --rm \
    --env http_proxy=$http_proxy \
    --env https_proxy=$https_proxy \
    --volume $(pwd):/local \
    quay.io/skopeo/stable:latest \
    copy \
    docker://docker.io/kubernetesui/dashboard:v${K8S_DASHBOARD_IMAGE_VERSION} \
    docker-archive:/local/dashboard/image-dashboard-v${K8S_DASHBOARD_IMAGE_VERSION}.tar:docker.io/kubernetesui/dashboard:v${K8S_DASHBOARD_IMAGE_VERSION}
# compress image archive
docker run \
    --rm \
    --env http_proxy=$http_proxy \
    --env https_proxy=$https_proxy \
    --volume $(pwd):/local \
    centos:latest \
    gzip \
    /local/dashboard/image-dashboard-v${K8S_DASHBOARD_IMAGE_VERSION}.tar

# download kubernetes-dashboard image
docker run \
    --rm \
    --env http_proxy=$http_proxy \
    --env https_proxy=$https_proxy \
    --volume $(pwd):/local \
    quay.io/skopeo/stable:latest \
    copy \
    docker://docker.io/kubernetesui/metrics-scraper:v${K8S_DASHBOARD_METRICS_SCRAPER_IMAGE_VERSION} \
    docker-archive:/local/dashboard/image-metrics-scraper-v${K8S_DASHBOARD_METRICS_SCRAPER_IMAGE_VERSION}.tar:docker.io/kubernetesui/metrics-scraper:v${K8S_DASHBOARD_METRICS_SCRAPER_IMAGE_VERSION}
# compress image archive
docker run \
    --rm \
    --env http_proxy=$http_proxy \
    --env https_proxy=$https_proxy \
    --volume $(pwd):/local \
    centos:latest \
    gzip \
    /local/dashboard/image-metrics-scraper-v${K8S_DASHBOARD_METRICS_SCRAPER_IMAGE_VERSION}.tar

# restore directory
popd
