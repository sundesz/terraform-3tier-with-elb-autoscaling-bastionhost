aws_region = "eu-north-1"

vpc_cidr          = "192.168.0.0/16"
public_cidrs      = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
private_cidrs     = ["192.168.11.0/24", "192.168.12.0/24", "192.168.13.0/24"]
availability_zone = ["eu-north-1a", "eu-north-1b"]

settings = {
  database = {
    engine         = "mysql"
    engine_version = "8.0"
    instance_class = "db.t3.micro"
    identifier     = "dbinstance"
    db_name        = "employees"
    username       = "root"
    password       = "Pa55w0rd!"
  }
}
