output "s3" {
  description = "Nombre del bucket"
  value = aws_s3_bucket.s3.bucket
}

/* output "instance_public_ip" {
  description = "IP publica de instancia EC2"
  value = aws_instance.instancia.public_ip
} */