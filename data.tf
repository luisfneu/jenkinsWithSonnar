data "aws_eks_cluster" "poc-cluster" {
  name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "poc-cluster" {
  name = module.my-cluster.cluster_id
}