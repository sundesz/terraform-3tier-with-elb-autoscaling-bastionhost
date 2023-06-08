output "private_subnets" {
  value = [aws_subnet.private_subnet_1a.id, aws_subnet.private_subnet_1b.id]
}

output "public_subnets" {
  value = [aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1b.id]
}

output "public_subnet_1a" {
  value = aws_subnet.public_subnet_1a.id
}

output "public_subnet_1b" {
  value = aws_subnet.public_subnet_1b.id
}

output "private_subnet_1a" {
  value = aws_subnet.private_subnet_1a.id
}

output "private_subnet_1b" {
  value = aws_subnet.private_subnet_1b.id
}

output "bastion_sg" {
  value = aws_security_group.bastion_host_sg.id
}

output "alb_web_sg" {
  value = aws_security_group.alb_web_sg.id
}

output "web_sg" {
  value = aws_security_group.web_sg.id
}

output "alb_app_sg" {
  value = aws_security_group.alb_app_sg.id
}

output "app_sg" {
  value = aws_security_group.app_sg.id
}

output "rds_sg" {
  value = aws_security_group.rds_sg.id
}
