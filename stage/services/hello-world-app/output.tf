output "alb_dns" {
  description = "DNS of load balancer for web server"
  value       = module.hello_world_app.alb_dns_name
}