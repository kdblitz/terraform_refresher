output "alb_dns_name" {
  description = "Domain name of load balancer"
  value       = module.alb.alb_dns_name
}

output "asg_name" {
  description = "Name of the auto scaling group"
  value       = module.asg.asg_name
}

output "instance_security_group_id" {
  description = "security group id for EC2 instances"
  value       = module.asg.instance_security_group_id
}