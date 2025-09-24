provider "aws" {
  region = var.aws_region
}

# Generate random suffix for global uniqueness
resource "random_id" "suffix" {
  byte_length = 4
}

# S3 bucket for Terraform state
resource "aws_s3_bucket" "tf_state" {
  bucket = "${var.s3_bucket_name}-${random_id.suffix.hex}"

  versioning {
    enabled = true
  }

  tags = {
    Name    = "terraform-state"
    Project = "sw-gitops"
  }
}

# DynamoDB table for Terraform state locking
resource "aws_dynamodb_table" "tf_lock" {
  name         = "${var.dynamodb_table_name}-${random_id.suffix.hex}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name    = "terraform-locks"
    Project = "sw-gitops"
  }
}
