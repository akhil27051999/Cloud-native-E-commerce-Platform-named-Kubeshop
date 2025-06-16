provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.vpc_cidr_block
}

module "eks_cluster" {
  source = "./modules/eks-cluster"
  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.subnet_ids
}

module "node_group" {
  source         = "./modules/node-group"
  cluster_name   = module.eks_cluster.cluster_name
  subnet_ids     = module.vpc.subnet_ids
  node_group_name = var.node_group_name
}

