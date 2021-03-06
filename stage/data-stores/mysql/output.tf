output "address" {
  description = "Connect to this db address"
  value       = module.mysql_module.address
}

output "port" {
  description = "Port to listen on"
  value       = module.mysql_module.port
}