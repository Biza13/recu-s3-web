output "s3" {
  description = "Nombre del bucket"
  value = aws_s3_bucket.s3.bucket
}