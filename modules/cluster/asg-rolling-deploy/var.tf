variable "cluster_name" {
  description = "name(prefix) used for cluster resources"
  type        = string
}

variable "ami" {
  description = "AMI to run on cluster"
  type        = string
  default     = "ami-0278fe6949f6b1a06"
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

variable "enable_autoscaling" {
  description = "set to true to enable autoscaling schedule"
  type        = bool
}

variable "custom_tags" {
  description = "custom tags to attach instances in ASG"
  type        = map(string)
  default     = {}
}

variable "server_port" {
  description = "Server port for http request"
  type        = number
  default     = 8080
}

variable "subnet_ids" {
  description = "subnet ids to deploy to"
  type        = list(string)
}

variable "target_group_arns" {
  description = "ARNs of ELB target groups in which to register instances"
  type        = list(string)
  default     = []
}

variable "health_check_type" {
  description = "Health check to perform (must be either EC2 or ELB)"
  type        = string
  default     = "EC2" 
}

variable "user_data" {
  description = "user data script to run in instances during boot"
  type        = string
  default     = null
}
