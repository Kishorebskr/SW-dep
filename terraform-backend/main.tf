provider "aws" {
  region = var.aws_region
}
resource "aws_s3_bucket" "tf_state" {
  bucket = var.s3_bucket_name
  versioning { enabled = true }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  lifecycle { prevent_destroy = true }
  tags = { Name = "terraform-state", Project = "sw-gitops" }
}
resource "aws_dynamodb_table" "tf_lock" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute { name = "LockID" type = "S" }
  tags = { Name = "terraform-locks", Project = "sw-gitops" }
}
