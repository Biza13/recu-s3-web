#backend usando el s3 que creo previamente en actions
terraform {
  backend "s3" {
    bucket         = "cubo-s3-begona"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate-bloqueo"
    encrypt        = true
  }
}