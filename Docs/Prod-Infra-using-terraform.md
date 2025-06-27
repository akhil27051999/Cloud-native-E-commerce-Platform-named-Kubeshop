# 🏗️ Section 6: Production-Grade Infrastructure using Terraform

This section describes how the entire AWS infrastructure was provisioned using Terraform, following Infrastructure as Code (IaC) practices.

### 📁 Folder Structure

```
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
└── modules/
    ├── vpc/
    ├── eks-cluster/
    └── node-group/
```

### 📌 Terraform Module Summary

| Module        | Purpose                                                 |
| ------------- | ------------------------------------------------------- |
| `vpc`         | Creates VPC, public/private subnets, route tables, etc. |
| `eks-cluster` | Provisions the EKS control plane and IAM roles.         |
| `node-group`  | Manages worker nodes using EC2 Auto Scaling Groups.     |

### 🛠️ main.tf Overview

```hcl
provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.vpc_cidr
}

module "eks_cluster" {
  source = "./modules/eks-cluster"
  cluster_name = var.cluster_name
  vpc_id = module.vpc.vpc_id
}

module "node_group" {
  source = "./modules/node-group"
  cluster_name = var.cluster_name
  subnet_ids = module.vpc.private_subnets
}
```

### ⚙️ Variables and Outputs

```hcl
# variables.tf
variable "region" {}
variable "vpc_cidr" {}
variable "cluster_name" {}
```

```hcl
# outputs.tf
output "eks_cluster_endpoint" {
  value = module.eks_cluster.endpoint
}
```

### ✅ Benefits of Terraform IaC

| Feature            | Benefit                                                  |
| ------------------ | -------------------------------------------------------- |
| Version Controlled | Infrastructure changes tracked via Git.                  |
| Reusable Modules   | Modular design improves reusability and consistency.     |
| Automation Ready   | Easily integrate with CI/CD pipelines.                   |
| Safe & Idempotent  | Ensures repeatable, rollback-capable infra provisioning. |

