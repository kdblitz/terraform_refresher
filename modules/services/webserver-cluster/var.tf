variable "server_port" {
  description = "Server port for http request"
  type        = number
  default     = 8080
}

variable "cluster_name" {
  description = "name(prefix) used for cluster resources"
  type        = string
}

variable "db_remote_state_bucket" {
  description = "s3 bucket containing db remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "path of remote state in s3"
  type        = string
}
