output "alb_dns" {
  description = "DNS of load balancer for web server"
  value       = module.webserver_cluster.alb_dns
}