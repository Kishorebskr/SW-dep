variable "aws_region" { default = "us-east-1" }
variable "cluster_name" { default = "sw-eks-cluster" }
variable "node_group_desired_capacity" { default = 2 }
variable "node_instance_type" { default = "t3.medium" }
variable "gitops_install_argocd" { default = true }
