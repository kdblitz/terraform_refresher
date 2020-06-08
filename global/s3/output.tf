output "s3_bucket_arn" {
  description = "ARN for s3 backend state"
  value       = aws_s3_bucket.terraform_state.arn
}

output "dynamodb_table_name" {
  description = "Name of dynamodb table"
  value       = aws_dynamodb_table.terraform_locks.name
}
