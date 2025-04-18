resource "aws_s3_bucket" "s3" {
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