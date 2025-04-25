module "my-cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.36.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnet_ids      = [aws_subnet.poc1-subnet.id, aws_subnet.poc2-subnet.id]
  vpc_id          = aws_vpc.poc-vpc.id


  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = var.worker_group_instance_type

    attach_cluster_primary_security_group = false
    vpc_security_group_ids                = [aws_security_group.allow-web-traffic.id]
  }

  eks_managed_node_groups = {
    blue = {
    }
    green = {
      min_size     = var.autoscaling_group_min_size
      max_size     = var.autoscaling_group_max_size
      desired_size = var.autoscaling_group_desired_capacity
      node_role_arn   = aws_iam_role.node_role.arn

      instance_types = var.worker_group_instance_type
      capacity_type  = "SPOT"
      labels = {
        Environment = "poc"
      }
    }
  }
}

resource "aws_iam_role" "node_role" {
  name = "eks-node-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.node_role.name
}

#resource "aws_iam_role_policy_attachment" "ebs_csi_attach" {
#  for_each = data.aws_eks_node_group.details

# policy_arn = data.aws_iam_policy.ebs_policy.arn
#  role       = split("/", each.value.node_role_arn)[1]
#}