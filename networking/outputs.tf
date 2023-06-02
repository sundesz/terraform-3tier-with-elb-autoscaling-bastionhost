output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

# Bastion host security group
output "bastion_host_sg" {
  value = aws_security_group.bastion_host_sg.id
}

# Web security group
output "webserver_sg" {
  value = aws_security_group.webserver_sg.id
}

# Database security group
output "rds_sg" {
  value = aws_security_group.rds_sg.id
}

# # General HTTP allow security group
# output "public_http_sg" {
#   value = aws_security_group.public_http_sg.id
# }

output "private_subnets" {
  value = [aws_subnet.private_subnet_1a.id, aws_subnet.private_subnet_1b.id]
}

output "public_subnets" {
  value = [aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1b.id]
}