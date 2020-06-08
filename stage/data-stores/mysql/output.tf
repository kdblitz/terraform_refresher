output "address" {
  description = "Connect to this db address"
  value       = aws_db_instance.db_server.address
}

output "port" {
  description = "Port to listen on"
  value       = aws_db_instance.db_server.port
}