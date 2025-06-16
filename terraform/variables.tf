variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  default     = "kube-shop-cluster"
}

variable "node_group_name" {
  description = "Node Group Name"
  default     = "kube-shop-nodes"
}

