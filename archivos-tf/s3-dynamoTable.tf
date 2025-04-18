resource "aws_s3_bucket" "backend_bucket" {
  bucket = var.s3

  tags = {
    Name        = "Backend Bucket"
    Environment = "Dev"
  }
}

resource "aws_dynamodb_table" "backend_lock_table" {
  name         = "tfstate-bloqueo"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Backend Lock Table"
    Environment = "Dev"
  }
}

#backend usando el s3 que creo previamente en actions
#terraform {
#  backend "s3" {
#    bucket         = "cubo-s3-begona"
#    key            = "terraform.tfstate"
#    region         = "us-east-1"
#    dynamodb_table = "tfstate-bloqueo"
#    encrypt        = true
#  }
#}