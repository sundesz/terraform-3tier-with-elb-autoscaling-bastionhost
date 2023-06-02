# Relational Database Service Subnet Group
resource "aws_db_subnet_group" "dbsubnet" {
  name       = "dbsubnet"
  subnet_ids = module.networking.private_subnets
}

# Create RDS Instance
resource "aws_db_instance" "dbinstance" {
  allocated_storage      = 5
  engine                 = var.settings.database.engine
  engine_version         = var.settings.database.engine_version
  instance_class         = var.settings.database.instance_class
  identifier             = var.settings.database.identifier
  db_name                = var.settings.database.db_name
  username               = var.settings.database.username
  password               = var.settings.database.password
  db_subnet_group_name   = aws_db_subnet_group.dbsubnet.id
  vpc_security_group_ids = [module.networking.rds_sg]
  skip_final_snapshot    = true
}