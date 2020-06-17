variable "environment" {
  description = "The name of environment"
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

variable "min_size" {
  description = "minimum count for auto scaling group"
  type        = number
}

variable "max_size" {
  description = "maximum count for auto scaling group"
  type        = number
}

variable "enable_autoscaling" {
  description = "set to true to enable autoscaling schedule"
  type        = bool
}

variable "ami" {
  description = "AMI to run on cluster"
  type        = string
  default     = "ami-0278fe6949f6b1a06"
}

variable "instance_type" {
  description = "EC2 type to run (eg. t2.micro)"
  type        = string
  default     = "t2.micro"
}

variable "server_port" {
  description = "Server port for http request"
  type        = number
  default     = 8080
}

variable "server_text" {
  description = "The output text of the server"
  type        = string
  default     = "Hello, world!"
}

variable "custom_tags" {
  description = "custom tags to attach instances in ASG"
  type        = map(string)
  default     = {}
}
