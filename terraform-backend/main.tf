provider "aws" { region = var.aws_region }
resource "aws_s3_bucket" "tf_state" { bucket = var.s3_bucket_name }
resource "aws_dynamodb_table" "tf_lock" { name = var.dynamodb_table_name hash_key = "LockID" attribute { name = "LockID" type = "S" } }
