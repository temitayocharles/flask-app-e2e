
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.29"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
  }
}

variable "kubeconfig_path" {
  type        = string
  description = "Full path to kubeconfig"
  default     = "/Users/charlie/.kube/config"
}

variable "kube_context" {
  type        = string
  description = "Kubectl context for Minikube"
  default     = "minikube-docker"
}

provider "kubernetes" {
  config_path    = var.kubeconfig_path
  config_context = var.kube_context
}

provider "helm" {
  kubernetes {
    config_path    = var.kubeconfig_path
    config_context = var.kube_context
  }
}

module "argocd" {
  source  = "squareops/argocd/kubernetes"
  version = "3.0.1"

  providers = {
    kubernetes = kubernetes # ✅ correct reference syntax
    helm       = helm
  }

  namespace     = "argocd"
  chart_version = "7.3.11"

  argocd_config = {
    hostname                     = "argocd.local"
    slack_notification_token     = ""
    redis_ha_enabled             = false
    autoscaling_enabled          = false
    argocd_notifications_enabled = false
    ingress_class_name           = "nginx"
    values_yaml                  = ""
  }
}
