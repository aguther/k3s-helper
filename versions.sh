#!/bin/bash

# define version(s) for skopeo
export CONTAINERS_COMMON_VERSION=0.55.2-1
export CRI_O_RUNC_VERSION=1.1.8-1
export SKOPEO_VERSION=1.13.1-1

# define k3s version(s)
export K3S_VERSION=1.27.3

# define helm version
export HELM_VERSION=3.12.2

# define k8s dashboard version(s)
export K8S_DASHBOARD_IMAGE_VERSION=2.7.0
export K8S_DASHBOARD_METRICS_SCRAPER_IMAGE_VERSION=1.0.8
export K8S_DASHBOARD_HELM_CHART_VERSION=6.0.8

# define command being used
export DOCKER_CMD=nerdctl
