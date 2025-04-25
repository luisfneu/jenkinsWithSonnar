# Jenkins Settings

variable "jenkins_admin_user" {
  type        = string
  description = "Usuário Admin Padrao."
  default     = "admin"
}

variable "jenkins_admin_password" {
  type        = string
  description = "Senha Admin padrao."
  default     = "admin"
}

# EKS Cluster Settings

variable "cluster_name" {
  type        = string
  description = "Nome do EKS."
  default     = "poc-cluster"
}

variable "cluster_version" {
  type        = string
  description = "Versão do EKS."
  default     = "1.32"
}

variable "worker_group_name" {
  type        = string
  description = "Nome do grupo de workers no EKS."
  default     = "poc-worker-group-1"
}

variable "worker_group_instance_type" {
  type        = list(string)
  description = "Tipo de instancia para subir os nós."
  default     = ["t3.large"]
}

variable "autoscaling_group_min_size" {
  type        = number
  description = "Numero minimo de nós."
  default     = 1
}

variable "autoscaling_group_desired_capacity" {
  type        = number
  description = "Numero desejado de nos que irá tentar manter."
  default     = 2
}

variable "autoscaling_group_max_size" {
  type        = number
  description = "Maximo de escala de nós."
  default     = 2
}

variable "create_cluster_primary_security_group_tags" {
  description = "Indicates whether or not to tag the cluster's primary security group. This security group is created by the EKS service, not the module, and therefore tagging is handled after cluster creation"
  type        = bool
  default     = true
}

# Networking Settings

variable "aws_region" {
  type        = string
  description = "Regiao AWS."
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  type        = string
  description = "Bloco CIDR da VPC."
  default     = "10.0.0.0/16"
}

variable "poc1_subnet_az" {
  type        = string
  description = "AZ da subnet 1."
  default     = "us-east-1a"
}

variable "poc2_subnet_az" {
  type        = string
  description = "AZ da subnet 2."
  default     = "us-east-1b"
}

variable "poc1_subnet_cidr_block" {
  type        = string
  description = "Bloco CIDR da subnet 1."
  default     = "10.0.1.0/24"
}

variable "poc2_subnet_cidr_block" {
  type        = string
  description = "Bloco CIDR da subnet 2."
  default     = "10.0.2.0/24"
}

variable "poc1_subnet_nic_private_ip" {
  type    = list(string)
  default = ["10.0.1.50"]
}

variable "node_group_names" {
  type = set(string)
  default = ["green-eks-node-group", "blue-eks-node-group"]
}