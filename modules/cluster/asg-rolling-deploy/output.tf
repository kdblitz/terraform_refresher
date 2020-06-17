output "asg_name" {
    description = "Name of the auto scaling group"
    value       = aws_autoscaling_group.server_asg.name
}

output "instance_security_group_id" {
    description = "security group id for EC2 instances"
    value       = aws_security_group.server_secgroup.id
}