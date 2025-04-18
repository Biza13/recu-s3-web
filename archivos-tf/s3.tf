#S3
resource "aws_s3_bucket" "s3"{    
  bucket = var.s3  #nombre que le pondremos al bucket

  tags = {
    name = "bucket"
    Enviroment = "Dev"
  }
}

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

terraform {
  backend "s3" {
    bucket = var.s3
    key = "terraform.tfstate" # Ruta del archivo tfstate en el bucket
    region = "us-east-1" # Región del bucket
    dynamodb_table = "tfstate-bloqueo" # Nombre de la tabla DynamoDB
    encrypt = true # Cifrar el estado
  }
}