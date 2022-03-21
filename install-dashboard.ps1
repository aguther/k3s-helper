# create target directory
multipass exec k3s -- mkdir -p /tmp/dashboard

# transfer files
multipass transfer ./k8s-dashboard/dashboard.admin-user-role.yml k3s:/tmp/dashboard/dashboard.admin-user-role.yml
multipass transfer ./k8s-dashboard/dashboard.admin-user.yml k3s:/tmp/dashboard/dashboard.admin-user.yml
multipass transfer ./k8s-dashboard/helm-kubernetes-dashboard-5.3.1.tgz k3s:/tmp/dashboard/helm-kubernetes-dashboard-5.3.1.tgz
multipass transfer ./k8s-dashboard/image-kubernetes-dashboard-v2.5.1.tar.gz k3s:/tmp/dashboard/image-kubernetes-dashboard-v2.5.1.tar.gz

# unzip image
multipass exec k3s -- gunzip /tmp/dashboard/image-kubernetes-dashboard-v2.5.1.tar.gz
# load image
multipass exec k3s -- sudo ctr images import /tmp/dashboard/image-kubernetes-dashboard-v2.5.1.tar

# install helm chart
multipass exec k3s -- helm install kubernetes-dashboard /tmp/dashboard/helm-kubernetes-dashboard-5.3.1.tgz --namespace kube-system --atomic

# deploy admin user
multipass exec k3s -- kubectl apply -f /tmp/dashboard/dashboard.admin-user-role.yml
multipass exec k3s -- kubectl apply -f /tmp/dashboard/dashboard.admin-user.yml

# delete temporary directory
multipass exec k3s -- rm -rf /tmp/dashboard
