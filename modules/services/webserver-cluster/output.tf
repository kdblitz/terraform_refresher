output "alb_dns" {
  description = "DNS of load balancer for web server"
  value = aws_lb.server_lb.dns_name
}