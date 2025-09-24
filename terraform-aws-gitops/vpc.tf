data "aws_availability_zones" "available" {}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">= 3.0.0"
  name = "${var.cluster_name}-vpc"
  cidr = "10.0.0.0/16"
  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnets  = ["10.0.0.0/19", "10.0.32.0/19"]
  private_subnets = ["10.0.64.0/19", "10.0.96.0/19"]
  enable_nat_gateway = true
  single_nat_gateway = true
}
