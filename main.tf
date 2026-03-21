resource "minikube_cluster" "docker" {
  driver       = "docker"
  cluster_name = "minikube-docker"
  addons = [
    "default-storageclass",
    "storage-provisioner"
  ]
}


