output "alb_dns_name" {
  description = "dns name for the load balancer"
  value       = aws_lb.server_lb.dns_name
}

output "alb_http_listener_arn" {
  description = "ARN of the http listener"
  value       = aws_lb_listener.http.arn
}

output "alb_security_group_id" {
  description = "security group id of the load balancer"
  value       = aws_security_group.alb_secgroup.id
}