data "aws_eks_cluster" "poc-cluster" {
  name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "poc-cluster" {
  name = module.my-cluster.cluster_id
}
# nodegroup
#data "aws_eks_node_groups" "all" {
#  cluster_name = module.my-cluster.cluster_id
#}

#data "aws_eks_node_group" "details" {
#  for_each        = toset(data.aws_eks_node_groups.all.names)
#  cluster_name    = module.my-cluster.cluster_id
#  node_group_name = each.key
#  
#  depends_on = [ module.my-cluster ]
#}

#IAM
data "aws_iam_policy" "ebs_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

data "aws_iam_policy_document" "eks_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}