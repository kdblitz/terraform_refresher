variable "server_port" {
  description = "Server port for http request"
  type        = number
  default     = 8080
}

variable "cluster_name" {
  description = "name(prefix) used for cluster resources"
  type        = string
}

variable "enable_autoscaling" {
  description = "set to true to enable autoscaling schedule"
  type        = bool
}

variable "enable_new_user_data" {
  description = "use new user data if true"
  type        = bool
}


variable "db_remote_state_bucket" {
  description = "s3 bucket containing db remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "path of remote state in s3"
  type        = string
}

variable "instance_type" {
  description = "EC2 type to run (eg. t2.micro)"
  type        = string
}

variable "min_size" {
  description = "minimum count for auto scaling group"
  type        = number
}

variable "max_size" {
  description = "maximum count for auto scaling group"
  type        = number
}

variable "custom_tags" {
  description = "custom tags to attach instances in ASG"
  type        = map(string)
  default     = {}
}