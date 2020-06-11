variable "user_names" {
  description = "IAM users to be generated"
  type        = list(string)
  default     = ["alice", "bob"]
}