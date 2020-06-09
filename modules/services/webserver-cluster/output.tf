output "alb_dns" {
  description = "DNS of load balancer for web server"
  value = aws_lb.server_lb.dns_name
}

output "asg_name" {
  description = "Name of auto scaling group"
  value       = aws_autoscaling_group.server_asg.name
}