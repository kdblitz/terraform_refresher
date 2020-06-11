output "all_arn" {
  description = "ARNs of all generated users"
  value       = values(aws_iam_user.gen_users)[*].arn
}