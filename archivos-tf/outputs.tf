output "s3" {
  description = "Nombre del bucket"
  value = aws_s3_bucket.s3.bucket
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.backend_lock_table.name
}