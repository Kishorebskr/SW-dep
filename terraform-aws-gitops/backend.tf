terraform {
  backend "s3" {
    bucket         = "sw-terraform-states"
    key            = "eks/gitops/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "sw-terraform-locks"
    encrypt        = true
  }
}
