#S3
#resource "aws_s3_bucket" "s3"{    
#  bucket = var.s3  #nombre que le pondremos al bucket

#  tags = {
#    name = "bucket"
#    Enviroment = "Dev"
#  }
#}

#dynamoDB
resource "aws_dynamodb_table" "tabla_dynamodb"{
  name = "tfstate-bloqueo"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"  #clave primaria

  attribute {
    name = "LockID"  #El attributo clave primaria
    type = "S"  #Va a ser tipo string
  }

  tags = {
    Enviroment = "Dev"
    name = "tfstate-bloqueo"
  }
}

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