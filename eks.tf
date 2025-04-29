module "my-cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.36.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnet_ids      = [aws_subnet.poc1-subnet.id, aws_subnet.poc2-subnet.id]
  vpc_id          = aws_vpc.poc-vpc.id
  cluster_endpoint_public_access = true
  # enable_cluster_creator_admin_permissions = true

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


      instance_types = var.worker_group_instance_type
      capacity_type  = "SPOT"
      iam_role_additional_policies = {
        ebs_csi = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }
    }
  }
    tags = {
    Environment = "poc"
    Terraform   = "true"
  }
}

