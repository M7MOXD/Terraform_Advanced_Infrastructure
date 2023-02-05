resource "aws_s3_bucket" "my_s3" {
  bucket = "my-s3-bucket-terraform-backend-m7moxd"
  lifecycle {
    prevent_destroy = true
  }
}
resource "aws_s3_bucket_versioning" "my_s3_versioning" {
  bucket = aws_s3_bucket.my_s3.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_dynamodb_table" "my_dynamodb" {
  name         = "my_dynamodb_table_terraform_backend_m7moxd"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
terraform {
  backend "s3" {
    bucket         = "my-s3-bucket-terraform-backend-m7moxd"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "my_dynamodb_table_terraform_backend_m7moxd"
    encrypt        = true
  }
}