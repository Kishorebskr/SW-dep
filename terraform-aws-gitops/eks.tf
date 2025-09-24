module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = ">= 19.0.0"
  cluster_name    = var.cluster_name
  cluster_version = "1.28"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  manage_aws_auth = true
  node_groups = {
    sw_nodes = {
      desired_capacity = var.node_group_desired_capacity
      max_capacity     = var.node_group_desired_capacity + 1
      min_capacity     = 1
      instance_types   = [var.node_instance_type]
      capacity_type    = "ON_DEMAND"
    }
  }
}
data "aws_eks_cluster" "cluster" { name = module.eks.cluster_id }
data "aws_eks_cluster_auth" "cluster" { name = module.eks.cluster_id }
