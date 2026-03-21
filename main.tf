resource "minikube_cluster" "docker" {
  driver       = "docker"
  cluster_name = "minikube-docker"
  addons = [
    "default-storageclass",
    "storage-provisioner"
  ]
}

module "argocd" {
  source  = "squareops/argocd/kubernetes"
  version = "3.0.1"
}
