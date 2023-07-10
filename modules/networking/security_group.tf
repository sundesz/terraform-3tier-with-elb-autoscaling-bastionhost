# Bastion host security group
resource "aws_security_group" "bastion_host_sg" {
  name        = "Bastion host sg"
  description = "Allow SSH access to bastion host"
  vpc_id      = var.vpc_id

  ingress {
    description = "allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "bastion-host-sg"
  }
}


# ALB Webserver server security group
resource "aws_security_group" "alb_web_sg" {
  name        = "Alb Web server sg"
  description = "Allow Web inbound traffic to web server"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "alb-web-server-sg"
  }
}

# Webserver server security group
resource "aws_security_group" "web_sg" {
  name        = "Web server sg"
  description = "Allow Web inbound traffic to web server from alb_web_sg"
  vpc_id      = var.vpc_id

  ingress {
    description     = "SSH from Bastion host"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_host_sg.id]
  }
  ingress {
    description     = "Allow HTTP access"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_web_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "web-server-sg"
  }
}

# ALB Application server security group
resource "aws_security_group" "alb_app_sg" {
  name        = "ALB Application server sg"
  description = "Allow traffic to application server"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow 8080 port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "alb-app-server-sg"
  }
}

# Application server security group
resource "aws_security_group" "app_sg" {
  name        = "Application server sg"
  description = "Allow traffic to application server from alb_app_sg"
  vpc_id      = var.vpc_id

  ingress {
    description     = "SSH from Bastion host"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_host_sg.id]
  }
  ingress {
    description     = "Allow 8080 port"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_app_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "app-server-sg"
  }
}


# RDS security group
resource "aws_security_group" "rds_sg" {
  name        = "rds security group"
  description = "Security group for databases"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow postgres traffic from only the app_sg"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  ingress {
    description     = "SSH from Bastion host"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_host_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "rds-sg"
  }
}