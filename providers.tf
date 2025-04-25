terraform {
  required_providers {
    aws = {
      version = "5.0"
    }
    helm = {
      version = "2.17.0"
    }
    kubernetes = {
      version = "2.36.0"
    }
  }
  required_version = "~> 1.5.7"
}
provider "helm" {
    kubernetes {
        host                   = data.aws_eks_cluster.poc-cluster.endpoint
        cluster_ca_certificate = base64decode(data.aws_eks_cluster.poc-cluster.certificate_authority.0.data)
            exec {
                api_version = "client.authentication.k8s.io/v1beta1"
                args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.poc-cluster.name]
                command     = "aws"
            }
    }
}

provider "kubernetes" {
    host                   = data.aws_eks_cluster.poc-cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.poc-cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.poc-cluster.token
    #load_config_file       = false
}

provider "aws" {
  region  = var.aws_region
  profile = "default"
}