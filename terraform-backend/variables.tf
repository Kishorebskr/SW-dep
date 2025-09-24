variable "aws_region" {
  description = "AWS region for backend"
  type        = string
  default     = "eu-central-1"
}

variable "s3_bucket_name" {
  description = "Base name of the S3 bucket for Terraform state (suffix added automatically)"
  type        = string
  default     = "sw-terraform-states"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for Terraform state locks"
  type        = string
  default     = "sw-terraform-locks"
}
