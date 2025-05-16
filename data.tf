data "aws_eks_cluster" "poc-cluster" {
  name = module.my-cluster.cluster_id # create cluster
  #name = module.my-cluster.cluster_name # install helm
}

data "aws_eks_cluster_auth" "poc-cluster" {
  name = module.my-cluster.cluster_id  # create cluster
  #name = module.my-cluster.cluster_name # install helm
}