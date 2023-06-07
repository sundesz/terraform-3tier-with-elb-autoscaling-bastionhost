# Show DB Instance Address
output "dbEndpoint" {
  description = "The endpoint of the database"
  value       = aws_db_instance.db_instance.address
}

output "dbPort" {
  description = "The port of the database"
  value       = aws_db_instance.db_instance.port
}

output "db_instance" {
  value = aws_db_instance.db_instance
}