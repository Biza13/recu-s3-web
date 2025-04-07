terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configurar la region de aws.
provider "aws" {
  region = var.region
}

#esto es para acceder al id de mi cuenta
data "aws_caller_identity" "current" {}

# Crear una VPC.
resource "aws_vpc" "Desarrollo-web-VPC" {
  cidr_block = var.vpc
  tags = {
    "Name" = "VPC"
  }
} 

#subred pública.
resource "aws_subnet" "subred-publica" {
  vpc_id = aws_vpc.Desarrollo-web-VPC.id
  cidr_block = var.cidrSubredPublica
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true        #necesario para las redes publicas
  tags = {
    "Name" = "subred-publica"
  }
}

# Crear una gateway para Internet (Internet Gateway)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.Desarrollo-web-VPC.id
  tags = {
    Name = "internet_gateway"
  }
}

#creacion de la tabla de enrutamiento
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.Desarrollo-web-VPC.id

  route {   //definir la ruta
    cidr_block = "0.0.0.0/0"   //permitir el trafico desde cualquier direccion ip hacia fuera de la vpc
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Tabla Enrutamiento para Internet gateway"
  }
}

#asociar la tabla de enrutamiento a la subred publica
resource "aws_route_table_association" "rt-asociacion-publica" {
  subnet_id = aws_subnet.subred-publica.id
  route_table_id = aws_route_table.public-rt.id
}