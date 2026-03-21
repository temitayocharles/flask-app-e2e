terraform {
  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = "0.6.0"
    }

    argocd = {
      source  = "argoproj-labs/argocd"
      version = "7.15.1"
    }
  }
}

provider "minikube" {
  kubernetes_version = "v1.30.2"
}

provider "kubernetes" {
  host = minikube_cluster.docker.host

  client_certificate     = minikube_cluster.docker.client_certificate
  client_key             = minikube_cluster.docker.client_key
  cluster_ca_certificate = minikube_cluster.docker.cluster_ca_certificate
}


provider "argocd" {
  auth_token                  = "1234567890"
  port_forward_with_namespace = "argocd"
  kubernetes {
    config_context = "minikube-docker"
  }
}
