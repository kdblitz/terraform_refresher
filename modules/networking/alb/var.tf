variable "alb_name" {
  description = "Name of the ALB"
  type        = string
}

variable "subnet_ids" {
  description = "subnet ids to deploy to"
  type        = list(string)
}