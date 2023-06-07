## LAB 160

# Relational Database Service Subnet Group
resource "aws_db_subnet_group" "dbsubnet" {
  name       = "dbsubnet"
  subnet_ids = [var.private_subnet_1a, var.private_subnet_1b]
}

# Create RDS Instance
resource "aws_db_instance" "db_instance" {
  allocated_storage      = var.rds_settings.allocated_storage
  engine                 = var.rds_settings.engine
  engine_version         = var.rds_settings.engine_version
  instance_class         = var.rds_settings.instance_class
  identifier             = var.rds_settings.identifier
  db_name                = var.rds_settings.db_name
  username               = var.rds_settings.username
  password               = var.rds_settings.password
  db_subnet_group_name   = aws_db_subnet_group.dbsubnet.id
  vpc_security_group_ids = [var.rds_sg]
  skip_final_snapshot    = var.rds_settings.skip_final_snapshot
}