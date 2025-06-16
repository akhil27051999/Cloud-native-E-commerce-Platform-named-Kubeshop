variable "cluster_name" {
  description = "EKS cluster name"
}

variable "node_group_name" {
  description = "Node group name"
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

